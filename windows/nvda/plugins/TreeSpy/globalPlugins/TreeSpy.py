# -*- coding: UTF-8 -*-
#
# TreeSpy NVDA plugin
#
# This source file is covered by the GNU General Public License version 3.
# There should be a file called license.txt included in the archive which contains this NVDA plug-in.
#
# Mike Ray, October 2013
# mike.ray@btinternet.com
#

import wx
import api
import winUser
import ui
import globalPluginHandler
import gui
import addonHandler
import tones
import controlTypes
from logHandler import log

# We initialize translation support
addonHandler.initTranslation()

# version numbers for caption bar
major = 1
minor =0

#: The singleton instance of the objTreeToolkit UI.
objTreeSpy = None

# indices into the 'location' list
LOC_LEFT = 0
LOC_TOP = 1
LOC_WIDTH = 2
LOC_HEIGHT = 3

class GlobalPlugin(globalPluginHandler.GlobalPlugin):
	def script_treeSpy(self, gesture):
		# Get the foreground object
		fg = api.getForegroundObject()
		activate(fg)
	
	def script_announceWindowClassName(self, gesture):
		focusObj = api.getFocusObject()
		name = focusObj.name
		windowClassName = focusObj.windowClassName
		ui.message("class for %s window: %s" % (name, windowClassName))
	
	def script_announceWindowControlID(self, gesture):
		focusObj = api.getFocusObject()
		name = focusObj.name
		windowControlID = focusObj.windowControlID
		ui.message("Control ID for %s window: %d" % (name, windowControlID))
	# these lines define what is spoken when the gesture is made with input help on (nvda+1, same to turn input help off)
	script_treeSpy.__doc__ = _("Opens a window showing the NVDA object hierarchy of the current foreground object")
	script_announceWindowClassName.__doc__ = _("Announce the windowClassName of the focussed control")
	script_announceWindowControlID.__doc__ = _("Announce the windowControlID of the focussed control")
	
	# gesture map for this plugin
	__gestures = {
		"kb:nvda+shift+o" : "treeSpy",
		"kb:NVDA+leftArrow": "announceWindowClassName",
		"kb:NVDA+rightArrow": "announceWindowControlID"
	}

class treeSpy(wx.Frame):
	def __init__(self, parent, obj):
		strCaption = _("Tree Spy "+str(major)+"."+str(minor)+" - ["+obj.appModule.appName+"]")
		super(treeSpy, self).__init__(parent, wx.ID_ANY, strCaption)
		
		self.fg = obj
		self.total = 0
		self.Bind(wx.EVT_ACTIVATE, self.onActivate)
		self.Bind(wx.EVT_CLOSE, self.onClose)
		
		# create a status bar
		self.sb = treeSpyStatusBar(self)
		self.SetStatusBar(self.sb)
		# panel and sizers
		mainPanel = wx.Panel(self, wx.ID_ANY)
		self.mainSizer = wx.BoxSizer(wx.HORIZONTAL)
		leftSizer = wx.BoxSizer(wx.VERTICAL)
		rightSizer = wx.BoxSizer(wx.VERTICAL)
		# this will go in the right sizer
		flexSizer = wx.FlexGridSizer( rows=8,cols=4, vgap=5, hgap=5)
		space = 6
		# tree stuff
		lblTree = wx.StaticText(mainPanel, wx.ID_ANY, "Object hierarchy:")
		self.tree = wx.TreeCtrl(mainPanel, wx.ID_ANY, size=(-1, -1), style=wx.TR_HAS_BUTTONS)
		self.tree.Bind(wx.EVT_CHAR, self.onOutputChar)
		self.Bind(wx.EVT_TREE_SEL_CHANGED, self.onSelChanged, self.tree)
		
		lblID = wx.StaticText(mainPanel, wx.ID_ANY, ".windowControlID:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtWindowControlID = wx.TextCtrl(mainPanel, wx.ID_ANY, "", size=(125, -1))
		lblName = wx.StaticText(mainPanel, wx.ID_ANY, ".name:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtName = wx.TextCtrl(mainPanel, wx.ID_ANY, "", size=(125, -1))
		lblValue = wx.StaticText(mainPanel, wx.ID_ANY, ".value:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtValue = wx.TextCtrl(mainPanel, wx.ID_ANY, "", size=(125, -1))
		lblRole = wx.StaticText(mainPanel, wx.ID_ANY, ".role:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtRole = wx.TextCtrl(mainPanel, wx.ID_ANY, "", size=(125, -1))
		self.chkVisible = wx.CheckBox(mainPanel, wx.ID_ANY, "Is visible")
		self.chkFocused = wx.CheckBox(mainPanel, wx.ID_ANY, "Has focus")
		lblStates = wx.StaticText(mainPanel, wx.ID_ANY, ".states:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.lstStates = wx.ListBox(mainPanel, wx.ID_ANY, pos=wx.DefaultPosition, size=wx.DefaultSize)
		# absolute location stuff
		sbAbsLoc = wx.StaticBox(mainPanel, wx.ID_ANY, "Absolute location")
		sbAbsLocSizer = wx.StaticBoxSizer( sbAbsLoc, wx.HORIZONTAL)
		flexAbsLocSizer = wx.FlexGridSizer( rows=4, cols=2, vgap=0, hgap=0)
		lblAbsLocLeft = wx.StaticText(mainPanel, wx.ID_ANY, "Left:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtAbsLocLeft = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		lblAbsLocTop = wx.StaticText(mainPanel, wx.ID_ANY, "Top:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtAbsLocTop = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		lblAbsLocWidth = wx.StaticText(mainPanel, wx.ID_ANY, "Width:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtAbsLocWidth = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		lblAbsLocHeight = wx.StaticText(mainPanel, wx.ID_ANY, "Height:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtAbsLocHeight = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		flexAbsLocSizer.AddMany([
			(lblAbsLocLeft, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtAbsLocLeft, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0),
			(lblAbsLocTop, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtAbsLocTop, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0),
			(lblAbsLocWidth, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtAbsLocWidth, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0),
			(lblAbsLocHeight, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtAbsLocHeight, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0)
		])
		sbAbsLocSizer.Add( flexAbsLocSizer, 0, wx.ALIGN_CENTRE|wx.ALL, 3 )
		
		# relative location stuff
		sbRelLoc = wx.StaticBox(mainPanel, wx.ID_ANY, "Relative location")
		sbRelLocSizer = wx.StaticBoxSizer( sbRelLoc, wx.HORIZONTAL)
		flexRelLocSizer = wx.FlexGridSizer( rows=4, cols=2, vgap=0, hgap=0)
		lblRelLocLeft = wx.StaticText(mainPanel, wx.ID_ANY, "Left:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtRelLocLeft = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		lblRelLocTop = wx.StaticText(mainPanel, wx.ID_ANY, "Top:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtRelLocTop = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		lblRelLocWidth = wx.StaticText(mainPanel, wx.ID_ANY, "Width:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtRelLocWidth = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		lblRelLocHeight = wx.StaticText(mainPanel, wx.ID_ANY, "Height:", style=wx.ALIGN_RIGHT|wx.ST_NO_AUTORESIZE)
		self.txtRelLocHeight = wx.TextCtrl(mainPanel, wx.ID_ANY, "-1", size=(50, -1))
		flexRelLocSizer.AddMany([
			(lblRelLocLeft, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtRelLocLeft, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0),
			(lblRelLocTop, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtRelLocTop, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0),
			(lblRelLocWidth, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtRelLocWidth, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0),
			(lblRelLocHeight, 0, wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL, 0),
			(self.txtRelLocHeight, 1, wx.EXPAND|wx.ALIGN_CENTER_VERTICAL, 0)
		])
		sbRelLocSizer.Add( flexRelLocSizer, 0, wx.ALIGN_CENTRE|wx.ALL, 3 )
		
		# pack it all in
		LABEL_FLAGS = wx.ALIGN_RIGHT|wx.ALIGN_CENTER_VERTICAL
		TEXT_FLAGS = wx.ALIGN_LEFT|wx.ALIGN_CENTER_VERTICAL
		flexSizer.AddMany([
			# row 1
			((-1, -1), wx.TOP, wx.EXPAND, 15),
			((-1, -1), wx.TOP, wx.EXPAND, 15),
			((-1, -1), wx.TOP, wx.EXPAND, 5),
			((-1, -1), wx.TOP, wx.EXPAND, 5),
			# row 2
			(lblID, 0, LABEL_FLAGS, 0),
			(self.txtWindowControlID, 1, TEXT_FLAGS, 0),
			(lblName, 0, LABEL_FLAGS, 0),
			(self.txtName, 1, TEXT_FLAGS, 0),
			# row 3
			(lblValue, 0, LABEL_FLAGS, 0),
			(self.txtValue, 1, TEXT_FLAGS, 0),
			(lblRole, 0, LABEL_FLAGS, 0),
			(self.txtRole, 1, TEXT_FLAGS, 0),
			# row 4
			(self.chkVisible, 1, TEXT_FLAGS, 0),
			(self.chkFocused, 1, TEXT_FLAGS, 0),
			(lblStates, 0, LABEL_FLAGS, 0),
			(self.lstStates, 1, TEXT_FLAGS, 0),
			# row 5
			(sbAbsLocSizer, 1, wx.EXPAND, 0),
			(sbRelLocSizer, 1, wx.EXPAND, 0),
			((-1, -1), 1, wx.EXPAND, 0),
			((-1, -1), 1, wx.EXPAND, 0)
			# spare row 6
			# spare row 7
			# spare row 8
		])

		# pack the left vertical box sizer
		leftSizer.Add(lblTree, proportion=0, flag=wx.ALIGN_LEFT|wx.TOP|wx.LEFT, border=7)
		leftSizer.Add(self.tree, proportion=1, flag=wx.ALIGN_LEFT|wx.EXPAND|wx.LEFT|wx.TOP, border=5)
		
		# pack the right vertical box sizer
		BOTH_SIDES = wx.LEFT|wx.RIGHT
		rightSizer.Add(flexSizer, proportion=1, flag=BOTH_SIDES|wx.TOP, border=20)
		
		# pack the main horizontal box sizer
		self.mainSizer.Add(leftSizer, proportion=1, flag=wx.ALIGN_TOP|wx.ALIGN_CENTER_HORIZONTAL|wx.EXPAND, border=0)
		self.mainSizer.Add(rightSizer, proportion=2, flag=wx.ALIGN_TOP|wx.ALIGN_LEFT, border=0)
		
		# set the main panel's sizer to the main horizontal box sizer
		mainPanel.SetSizer(self.mainSizer)
		self.mainSizer.Fit(mainPanel)
		self.Fit()
		
		# make the menu
		menuBar = wx.MenuBar()
		menu1 = wx.Menu()
		item = menu1.Append(wx.ID_EXIT, _("E&xit"))
		self.Bind(wx.EVT_MENU, self.onClose, item)
		menuBar.Append(menu1, _("File"))
		menu2 = wx.Menu()
		item = menu2.Append(wx.ID_ANY, _("&Expand all"))
		self.Bind(wx.EVT_MENU, self.onExpandAll, item)
		item = menu2.Append(wx.ID_ANY, _("&Collapse all"))
		self.Bind(wx.EVT_MENU, self.onCollapseAll, item)
		item = menu2.Append(wx.ID_ANY, _("F&ind focused object"))
		self.Bind(wx.EVT_MENU, self.onFindFocus, item)
		menuBar.Append(menu2, _("Tree"))


		self.SetMenuBar(menuBar)
		
		self.root = self.tree.AddRoot(obj.windowClassName)
		self.tree.SetPyData(self.root, obj)
		
		self.focusNode = None
		self._loadTree(self.root, obj)
		self.sb.SetStatusText("Total = " + str(self.total), 0)
		self.tree.SetFocus()
	
	def onSetFocus(self, evt):
		evt.Skip()
	
	def onKillFocus(self, evt):
		evt.Skip()
	
	def onWindowDestroy(self, evt):
		evt.Skip()
	
	def EvtText(self, event):
		pass
	
	def EvtTextEnter(self, event):
		event.Skip()
	
	def EvtChar(self, event):
		event.Skip()
	
	def onActivate(self, evt):
		evt.Skip()
	
	def onClose(self, evt):
		self.Destroy()

	def onExpandAll(self, evt):
		self.tree.ExpandAll()
	def onCollapseAll(self, evt):
		self.tree.CollapseAll()
	
	def onFindFocus(self, evt):
		if self.focusNode:
			self.tree.SelectItem(self.focusNode)
	
	def onOutputChar(self, evt):
		key = evt.GetKeyCode()
		if key == wx.WXK_ESCAPE:
			self.Close()
		evt.Skip()
	def onClick(self, evt):
		text = self.txtName.GetValue()
		evt.Skip()
	
	def onSelChanged(self, evt):
		self.selectedNode = evt.GetItem()
		if self.selectedNode:
			# retrieve the nvda object from the tree item data
			self.obj = self.tree.GetPyData(self.selectedNode)
			self.sb.SetStatusText("Children = " + str(len(self.obj.children)), 1)
			self.txtWindowControlID.ChangeValue(str(self.obj.windowControlID))
			if self.obj.name:
				self.txtName.ChangeValue(self.obj.name)
			else:
				self.txtName.ChangeValue("")
			if self.obj.value:
				self.txtValue.ChangeValue(self.obj.value)
			else:
				self.txtValue.ChangeValue("")
			self.txtRole.ChangeValue(controlTypes.roleLabels[self.obj.role])
			if winUser.isWindowVisible(self.obj.windowHandle):
				self.chkVisible.SetValue(True)
			else:
				self.chkVisible.SetValue(False)
			if controlTypes.STATE_FOCUSED in self.obj.states:
				self.chkFocused.SetValue(True)
			else:
				self.chkFocused.SetValue(False)
			self.txtAbsLocLeft.ChangeValue(str(self.obj.location[LOC_LEFT]))
			self.txtAbsLocTop.ChangeValue(str(self.obj.location[LOC_TOP]))
			self.txtAbsLocWidth.ChangeValue(str(self.obj.location[LOC_WIDTH]))
			self.txtAbsLocHeight.ChangeValue(str(self.obj.location[LOC_HEIGHT]))
			self.txtRelLocLeft.ChangeValue(str(self.obj.location[0]-self.fg.location[LOC_LEFT]))
			self.txtRelLocTop.ChangeValue(str(self.obj.location[1]-self.fg.location[LOC_TOP]))
			self.txtRelLocWidth.ChangeValue(str(self.obj.location[LOC_WIDTH]))
			self.txtRelLocHeight.ChangeValue(str(self.obj.location[LOC_HEIGHT]))
			self.lstStates.Clear()
			for state in self.obj.states:
				self.lstStates.Append(controlTypes.stateLabels[state], None)
				self.lstStates.SetSelection(0)
	
	# depth-first recursive function to populate the tree
	def _loadTree(self, tvItem, obj):
		self.total += 1
		for child in obj.children:
			# add an item to the tree then recursively call this function or drop thru for a a leaf node object
			if child.hasFocus:
				f = ' (focused)'
			else:
				f = ''
			tvi = self.tree.AppendItem(tvItem, child.windowClassName+f)
			if child.hasFocus:
				self.focusNode = tvi
			self.tree.SetPyData(tvi, child)
			self._loadTree(tvi, child)
		
		# drop through for leaf nodes
		
class treeSpyStatusBar(wx.StatusBar):
	def __init__(self, parent):
		wx.StatusBar.__init__(self, parent, -1)
		
		# This status bar has two fields
		self.SetFieldsCount(2)
		
		# Sets the two fields to be relative widths to each other.
		self.SetStatusWidths([-1, -1])
		self.sizeChanged = False
		self.Bind(wx.EVT_SIZE, self.OnSize)
		
	def OnSize(self, evt):
		self.sizeChanged = True

# to store a Python object in a tree node it has to be an attribute of
# a sub-class of wx.TreeItemData
class objectTreeNode(wx.TreeItemData):
	def __init__(self, obj):
		self.obj = obj
		


def activate(obj):
	"""activate the object tree viewer
	If the object tree viewer has not already been created and opened, this will create and open it.
	Otherwise, it will be brought to the foreground if possible.
	"""
	global objTreeSpy
	if not objTreeSpy:
		objTreeSpy = treeSpy(gui.mainFrame, obj)
		
	objTreeSpy.Raise()
	# There is a MAXIMIZE style which can be used on the frame at construction, but it doesn't seem to work the first time it is shown,
	# probably because it was in the background.
	# Therefore, explicitly maximise it here.
	# This also ensures that it will be maximized whenever it is activated, even if the user restored/minimised it.
	objTreeSpy.Maximize()
	objTreeSpy.Show()

# bottom of code
