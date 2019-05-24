# LabVIEW-Developing-QuickDrops

"NI LabVIEW palettes contain hundreds of useful VIs and functions, but, when you know the exact VI you need, navigating through the palette can take too much time. Quick Drop lets you rapidly find and place LabVIEW front panel and block diagram objects without navigating the palettes or initiating a search."

-- [Boost Productivity with Quick Drop](http://www.ni.com/tutorial/7423/en/)

## Default Key-QD Mapping

`A` --> `[Ctrl]` Align and Distribute</br>
`B` --> `[Ctrl]` Build Array of References</br>
`C` --> `[Ctrl]` Clear Array</br>
`D` --> `[LabVIEW Build-in]` `[Ctrl]` Wire All Terminals</br>
`E` --> _Reserved_</br>
`F` --> `[Ctrl]` Arrange VI Window</br>
`G` --> `[Ctrl]` `[Shift]` Create a Place VI Contents</br>
`H` --> _Reserved_</br>
`I` --> `[LabVIEW Build-in]` `[Ctrl]` `[Shift]` Insert</br>
`J` --> _Reserved_</br>
`K` --> _Reserved_</br>
`L` --> `[Ctrl]` `[Shift]` Create FGV</br>
`M` --> _Reserved_</br>
`N` --> `[Ctrl]` Format Numeric</br>
`O` --> `[Ctrl]` Smart Open VI Location in Explorer Window</br>
`P` --> `[LabVIEW Build-in]` `[Ctrl]` Replace</br>
`Q` --> `[Ctrl]` NEVSTOP QD Shortcuts (ChoosingDialog)</br>
`R` --> `[LabVIEW Build-in]` `[Ctrl]` Remove And Rewire</br>
`S` --> `[Ctrl]` State Machine from Enum</br>
`T` --> `[LabVIEW Build-in]` `[Ctrl]` `[Shift]` Move Labels</br>
`U` -->  `[Ctrl]` `[Shift]` Cluster Auto-Sizing</br>
`V` --> _Reserved_</br>
`W` --> `[LabVIEW Build-in]` `[Ctrl]` `[Shift]` Wire Multiple Objects Together</br>
`X` --> _Reserved_</br>
`Y` --> _Reserved_</br>
`Z` --> _Reserved_</br>

## Tools/NEVSTOP/QuickDrop Menu

```
Import QD Shortcuts.vi
Export QD Shortcuts.vi
-
Open LabVIEW Folder.vi
Open Customized Ini Tokens Folder.vi
Merge Tokens of Ini Files.vi
-
Update QuickDrop ShortCuts Hints.vi
```
- `Export QD ShortCuts`    
   Export customized shortcuts settings to ini file.
- `Import QD ShortCuts`    
   Import customized shortcuts settings from an ini file.

- `Open LabVIEW Folder.vi`   
   Open LabVIEW Folder to view the LabVIEW.ini and LabVIEW.ini.bk.txt files.
- `Open Customized Ini Tokens Folder.vi`  
   Open the folder of customized ini files.
- `Merge Tokens of Ini Files.vi`   
   Merge the selected ini tokens to LabVIEW.ini file.
   
- `Update QuickDrop ShortCuts Hints`   
   Update the Hints in Block Diagram Quick Drop Window after you change the Key-QD Mapping


## LabVIEW Built-in QuickDrops

### Insert

Inserts the object specified by name in the Quick Drop dialog box on the selected wire(s) on the diagram.  If [Shift] is also pressed, and multiple wires were selected, a single instance of the object is inserted on those wires.

```
Default Shortcut - [I]
Default Shortcut - [Shift][I]
```

### Replace

Replaces the selected panel or diagram object(s) with the object specified by name in the Quick Drop dialog box.

```
Default Shortcut - [P]
```

### Remove And Rewire

Removes the selected block diagram object(s) and any wires and constants connected to the selected object(s), and connects wires of identical data types that were wired to the inputs and outputs of the deleted object(s).

```
Default Shortcut - [R]
```

### Wire Multiple Objects Together

Connects compatible terminals between multiple selected diagram objects. This shortcut will wire compatible data types between the objects in a left-to-right fashion. If [Shift] is also pressed, LabVIEW will perform a diagram cleanup of the selected objects after wiring them together.

```
Default Shortcut - [W]
Default Shortcut - [Shift][W]
```

### Wire All Terminals

Creates controls and indicators for all unwired inputs and outputs of the selected block diagram object(s).  If 'shift' is also pressed, creates constants for all unwired inputs of the selected block diagram object(s).

```
Default Shortcut - [D]
```

### Move Labels

Repositions the visible labels or captions of top-level front panel and block diagram objects to be consistent with the "Default label position" settings in Tools > Options. If [Shift] is also pressed, then all objects, including nested objects, are modified. If this shortcut is activated from the front panel, then controls and indicators are modified. If it is activated from the block diagram, then control and indicator terminals are modified. If panel or diagram objects were already selected when this shortcut is activated, only the selected objects that have visible labels or captions are modified.

The text justification of the modified labels and captions is also modified to be consistent with the new label or caption position.

```
Default Shortcut - [T]
Default Shortcut - [Shift][T]
```


## QD_NEVSTOP

### NEVSTOP QD Shortcuts(Choosing Dialog)

NEVSTOP Quickdrops. Using a choosing dialog for quick QD selection.

```
Default Shortcut - [Q]
```

### Clone Controls

This Quick Drop Keyboard Shortcut will clone the selected Control(s) or Indicator(s) on the Front Panel but changes Controls to Indicators and vice versa.  In addition, if found on the Connector Pane, it will attempt to place the newly created control on the opposite (left / right) side of the Connector Pane.

It was developed to automate the task where, for example,  you have a File Ref (in) control, and you want to wire it through the other side of the ConPane.

Note: This script only supports the following patterns: 4x2x2x4, 5x3x3x5, 6x4x4x6, and 8x6x6x8


### Clear Array

Clears the selected array(s) and sets the default value to empty. If shift is also pressed while viewing the front panel, it will affect all front panel arrays, regardless of selection. 

```
Default Shortcut - [C]
```

### Refresh Palette

After some chane of Control/Function Pallette, you can manually update the pallette with this quickdrop.


### Smart Open VI Location in Explorer Window

Publish with 2 other QuickDrop:
 - `Open Current VI's Location in Explorer Window`
 - `Open Selected VI's Location in Explorer Window`

When triggered on Front Panel:
Open Current VI's Location in Explorer Window.

When triggered on Block Diagram:
No SubVI is selected: Open Current VI's Location in Explorer Window.
SubVIs are selected: Open Selected VI's Location in Explorer Window.

```
Default Shortcut - [O]
```

## 3r Party QuickDrops

### Arrange VI Window

**link**:[Quick Drop Keyboard Shortcut – Arrange VI Window](https://forums.ni.com/t5/Quick-Drop-Enthusiasts/Quick-Drop-Keyboard-Shortcut-Arrange-VI-Window/gpm-p/3867352?profile.language=zh-CN)    
**Author**:Kosta

When used on the front panel:
-Arranges controls and indicators to be consistent with the connector pane arrangement. 
-Resizes and moves the front panel to a consistent top left location on the primary monitor.

When used on the block diagram:
-Scrolls the block diagram to a reasonable location relative to the top-most and/or left-most diagram object.
-Resizes and moves the block diagram to a consistent top left location on the primary monitor.

```
Default Shortcut - [F]
```

### While Loop Subdiagram Label

Takes the text in the Quick Drop box and applies it as a subdiagram label to a While Loop, and formats the subdiagram label to have white, bold text, with the while loop's gray background color.

```
Default Shortcut - NaN
```

### Create FGV

**link**:[Quick Drop Keyboard Shortcut - Create FGV (and RT FGV)](https://forums.ni.com/t5/Quick-Drop-Enthusiasts/Quick-Drop-Keyboard-Shortcut-Create-FGV-and-RT-FGV/gpm-p/3497469?profile.language=zh-CN)    
**Author**:Florent_A

PLUGIN_DESCRIPTION: 
Create a FGV base on wire, control, indicator or constante datatype you select.
2 FGV Templates are available: a classic FGV and a RT FGV what is made to be skipable (please see Template FGV folder)

```
Default Shortcut - [L]
Default Shortcut - [Shift][L]
```

### Create a Place VI Contents

**link**: [Create a Place VI Contents](https://decibel.ni.com/content/docs/DOC-12725)  
**Author**:Jarrod S


(Note: The following shortcut was originally posted by Jarrod S. on the NI Forums here.  I decided to give his shortcut a more permanent home in the Quick Drop Enthusiasts group.)

This Quick Drop Keyboard Shortcut allows you to create a Place VI Contents VI (formerly called a "Merge VI") of your diagram selection and automatically create a user.lib palette entry for it, so that you can easily drop that selection of code in the future.  Follow these steps to use this shortcut:

Save the attached VI in your <LabVIEW>\resource\dialog\QuickDrop\plugins folder.  No LabVIEW restart is required.
Select something on your diagram that you wish to make into a Place VI Contents VI.
Press Ctrl-Space-Ctrl-Shift-G.
Specify a name for this Place VI Contents VI.
Create an icon

Now you have a Place VI Contents VI that contains this diagram selection that you can use from your palettes (or Quick Drop).  Note that in step (3) above, if you had pressed Ctrl-Space-Ctrl-G instead, the palettes would not be refreshed automatically, and you would have to restart LabVIEW in order to use the new Place VI Contents VI.

Note:  All Place VI Contents VIs that are created with this shortcut are stored in <LabVIEW Data>\QuickDrop Templates.  The actual .mnu files that provide the palette entries are stored in <LabVIEW>\user.lib\QuickDrop Templates Palette.mnu.

```
Default Shortcut - [G]
Default Shortcut - [Shift][G]
```

### State Machine from Enum

**link**: [QDKS - State Machine from Enum](https://forums.ni.com/t5/Quick-Drop-Enthusiasts/QDKS-State-Machine-from-Enum/gpm-p/3524404?profile.language=zh-CN)  
**Author**:Eric M.

I am kind of emo to post my first QD here. I figured this one would be of use for quite a bunch of developers.

Goal :
Pretty much everyone uses state machines as this is a rather basic but efficient design pattern that can be mixed together with others DPs. Whichever the platform (RT, FPGA, Win), an application will most likely include a state machine (or more!).

First thing : create the enum that will describe the states of the machine. Yeah well, with this QDKS, that's roughly the only thing you will need to do.

How-To :
- Copy the attached QD VI to the usual directory.
- Configure its key (S is fine !)
- Select an enum terminal or constant in your BD. Make sure there is some free space at the right of the enum.
- Ctrl+Space Ctrl+Key. You've earned a state machine corresponding to the enum items.

```
Default Shortcut - [S]
```

### Reset Origin

**link**: [Reset Origin](https://forums.ni.com/t5/Quick-Drop-Enthusiasts/Quick-Drop-Plugin-Reset-Origin/gpm-p/3527195?profile.language=zh-CN)  
**Author**:Andreas S

Note: This shortcut ships with LabVIEW 2018 and later with a default assignment of Ctrl-O. You only need to download it from here if you are using LabVIEW 2017 or previous.

Resets the origin for all panes or the block diagram.


### Format Numeric
**link**: [Format Numeric](https://forums.ni.com/t5/Quick-Drop-Enthusiasts/Format-Numeric-vi/gpm-p/3492847?profile.language=zh-CN)  
**Author**:crossrulz

In response to a couple of ideas from the Idea Exchange (here and here), I was inspired to make a quick drop shortcut to attempt to accomadate the spirit of the ideas: a better way to format your numeric controls, indicators, and constants.  So here is my plug in.

To install

Put VI in the <LabVIEW>\resource\dialog\QuickDrop\plugins folder.

How to use

Open quick drop (Ctrl+Space)
Type in the format specifier you want (I will use %02x as an example)
Press Ctrl+N (N for numeric)
Any controls, constants, or indicators that you selected that can accept that format will be set to display in that format
Future additions I would like to do

Automatically show the radix if setting to hex, octal, or binary display.

```
Default Shortcut - [N]
```

### Build Array of References/Build Cluster of References

Create references with 'Build Array'/'buddle' together.

```
Default Shortcut - [B]
```

### Align and Distribute

Align and Distribute slected controls/indicators/SubVIs. A pop-up dialog will be used for selecting the way you want.

```
Default Shortcut - [A]
```

### Cluster Auto-Sizing

Using a float dialog to choose cluster auto-sizing type. Press `Shift` to set the contained cluster items recursively. 
- None
- Size to Fit
- Arrange Horizontally
- Arrange Vertically

```
Default Shortcut - [U]
Default Shortcut - [Shift][U]
```



