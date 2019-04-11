# LabVIEW-Developing-QuickDrops

Quick Drop 是 LabVIEW 开发的辅助工具，可以大大的提高开发效率。

## LabVIEW 自带的 QuickDrops

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

### **Wire Multiple Objects Together**

Connects compatible terminals between multiple selected diagram objects. This shortcut will wire compatible data types between the objects in a left-to-right fashion. If [Shift] is also pressed, LabVIEW will perform a diagram cleanup of the selected objects after wiring them together.

```
Default Shortcut - [W]
Default Shortcut - [Shift][W]
```

### **Wire All Terminals**

Creates controls and indicators for all unwired inputs and outputs of the selected block diagram object(s).  If 'shift' is also pressed, creates constants for all unwired inputs of the selected block diagram object(s).

```
Default Shortcut - [D]
```

### **Move Labels**

Repositions the visible labels or captions of top-level front panel and block diagram objects to be consistent with the "Default label position" settings in Tools > Options. If [Shift] is also pressed, then all objects, including nested objects, are modified. If this shortcut is activated from the front panel, then controls and indicators are modified. If it is activated from the block diagram, then control and indicator terminals are modified. If panel or diagram objects were already selected when this shortcut is activated, only the selected objects that have visible labels or captions are modified.

The text justification of the modified labels and captions is also modified to be consistent with the new label or caption position.

```
Default Shortcut - [T]
Default Shortcut - [Shift][T]
```