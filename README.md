# Diagram

![Weak or Unowned Example](./MRT%20Jakarta%20Navigation%20Use%20Cases-Weak%20or%20Unowned%20Example.drawio.svg)

# To Do

- [x] generic Coordinator.

    ![Coordinator](./Reference%20In%20Swift-Coordinator.drawio.svg)

# Notes

- `var coordinator` should live in ViewModel and not in View because View should be as dumb as possible. 

    `WeakExample` and `UnownedExample` are exempt to focus on the usage of `weak` and `unowned` keyword in the design patterns.
    
    Consequently, we violate the principle and put `var coordinator` in the View.
