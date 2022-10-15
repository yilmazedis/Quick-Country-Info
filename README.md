# Quick Country Info

## General Explanation
### Usage
- Click a continent, then click a country, after that, you will see that country quick informations
- Tab search bar in the TabBar, then search a country and select it. After that, you will see that country quick informations

### Structure
- Error & Load handle
- I used MVVM as default design pattern
- I devided Constants, Extension, Enumeration, protocols as much as possible.
- I devided groups with related files.
- I added comment as much as possible, rather I prefered well designed function and property names.
- I try to avoid retain cycle, and cared variables reference count.
- I try to avoid massive ViewController. So, I devided function with related extensions.
- I just developed ContinentsViewController with UITableViewController to show how looking. Other controllers developed with UIViewController as usual.

- Finally, I added a demo to demonstrate my work. ->

 |       Ver-1-Demo         |      Final Demo           |
:-------------------------:|:-------------------------:|
![](DemoGifs/Ver-1-Demo.gif) | ![](DemoGifs/Final-Demo.gif)
