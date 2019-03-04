# UIView+Autolayout
A UIView class that will help you adding constraints programatically


# Usage
1. Add UIView+Autolayout class to your project.
2. use the view to add contraints.
(Note make sure to add the view add into superview. It will give assert failure message otherwise)


### Example 1 - 

```swift

        view.addSubview(tableView)
        
        let top = getTopSafeMargin()
        tableView.addTopMargin(top)
        tableView.addLeadingMargin()
        tableView.addTrailingMargin()
        tableView.addBottomMargin()
```

### Example 2 - 

```swift
        let view1 = UIView()
        view.addSubview(view1)
        
        view1.addAllMargins() 
        //to add subview with zero margins
        
        
        let view2 = UIView()
        view.addSubview(view2)
        
        view2.addAllMargins(top: 10, bottom: 10, leading: 10, trailing: 10)
       //to add subview with custom margins


        
```
