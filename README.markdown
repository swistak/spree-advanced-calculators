Advanced Calculators
==========================
**Supports Spree >= 0.9.x**

Adapted from code by _Michael Lang_ by _Marcin Raczkowski_.

old version that works with 0.8 code can be found at http://github.com/mwlang/spree-price-bucket-shipping-calculator/tree/master

Advanced Calculators allow you to define shipping costs based on shipping method
and ranges of parameters from line items.

When installed, a new "Advenced Caclulators Settings" link is added to the
Configuration area in the Spree administration interface.
There after creating one of advanced calculators you can define as many
different rates as required, and link them to the relevant Calculator.

Each advanced calculator contains the following values:

1. **Calculator:** Each Rate is associated with a _Calculator_, which is used to calculate charges.

2. **Floor:** This is the lower bound for rate.  The value _is not_ included.

3. **Ceiling:** This is the upper bound for rate. This value _is_ inclusive.

4. **Shipping Rate:** Is the shipping charge to apply to the order for
 order's that fall within ththe renge set by Floor and Ceiling.

Quick Start
===========
1. Install extension:

    `script/extension install git://github.com/swistak/spree-advanced-calculators.git`

2. Migrate the database (or bootstrap if you want the sample data for testing)

    `rake db:migrate`
