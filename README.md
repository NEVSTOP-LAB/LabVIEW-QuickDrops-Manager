# LabVIEW-Developing-QuickDrops

"NI LabVIEW palettes contain hundreds of useful VIs and functions, but, when you know the exact VI you need, navigating through the palette can take too much time. Quick Drop lets you rapidly find and place LabVIEW front panel and block diagram objects without navigating the palettes or initiating a search."

-- [Boost Productivity with Quick Drop](http://www.ni.com/tutorial/7423/en/)

## Default Key-QD Mapping

`A` --> `Clone Controls`    
`B` --> _Reserved_  
`C` --> `Clear Array`  
`D` --> `Wire All Terminals`(LabVIEW Built In)      
`E` --> _Reserved_  
`F` --> `Arrange VI Window`  
`G` --> _Reserved_  
`H` --> _Reserved_  
`I` --> [Shift] `Insert` (LabVIEW Built In)     
`J` --> _Reserved_  
`K` --> _Reserved_  
`L` --> [Shift] `Create FGV`  
`M` --> _Reserved_  
`N` --> _Reserved_  
`O` --> _Reserved_  
`P` --> `Replace`(LabVIEW Built In)     
`Q` --> _Reserved_  
`R` --> `Remove And Rewire`(LabVIEW Built In)       
`S` --> _Reserved_  
`T` --> [Shift] `Move Labels` (LabVIEW Built In)        
`U` --> _Reserved_  
`V` --> _Reserved_  
`W` --> [Shift] `Wire Multiple Objects Together`(LabVIEW Built In)      
`X` --> _Reserved_  
`Y` --> _Reserved_  
`Z` --> _Reserved_  

## Tools/NEVSTOP/QuickDrop Menu

 - `Update QuickDrop ShortCuts Hints`   
    Update the Hints in Block Diagram Quick Drop Window after you change the Key-QD Mapping
 - `Export QD ShortCuts`    
    Export customized shortcuts settings to ini file.
 - `Import QD ShortCuts`    
    Import customized shortcuts settings from an ini file.


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

## Additional QuickDrops

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

### Clone Controls

This Quick Drop Keyboard Shortcut will clone the selected Control(s) or Indicator(s) on the Front Panel but changes Controls to Indicators and vice versa.  In addition, if found on the Connector Pane, it will attempt to place the newly created control on the opposite (left / right) side of the Connector Pane.

It was developed to automate the task where, for example,  you have a File Ref (in) control, and you want to wire it through the other side of the ConPane.

Note: This script only supports the following patterns: 4x2x2x4, 5x3x3x5, 6x4x4x6, and 8x6x6x8

```
Default Shortcut - [A]
```

### Clear Array

Clears the selected array(s) and sets the default value to empty. If shift is also pressed while viewing the front panel, it will affect all front panel arrays, regardless of selection. 

```
Default Shortcut - [C]
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