# Takeaway Project

My version of the takeaway project in Makers Week 2.

## User Stories

`As a customer` \
`So that I can check if I want to order something` \
`I would like to see a list of dishes with prices.`

`As a customer` \
`So that I can order the meal I want` \
`I would like to be able to select some number of several available dishes.`

`As a customer` \
`So that I can verify that my order is correct` \
`I would like to see an itemised receipt with a grand total.`

`As a customer` \
`So that I am reassured that my order will be delivered on time` \
`I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.`

## Skills developed

 - developed a multi-class program 
 - used TDD
 - interpreted user stories
 - used mocking extensively, including for sending a text via twilio and 'puts' and 'gets'
 - used OOP, separating classes. This is particularly helpful as I developed on the original brief by making it function in terminal,
 and this was easier thanks to OOP - only the 'order_for_terminal' class is responsible for this

If I had more time, I would:
 - make it so that menu items can be entered by the user without them needing to use the correct capitalization
 - have the receipt list items with the number of times, e.g. (1 x Vegetable Rice, 2 x Vegetable Spring Rolls)
 - complete unit tests for `OrderForTerminal` class using mocking 

If I expanded on the project, I would be interested in:
 - having multiple menus for the user to select from
 - allowing users to deselect items

## Functionality

Users have to set the following Environmental variables, using their own twilio account:

`TWILIO_ID`

`TWILIO_AUTH_TOKEN`

`TWILIO_NUMBER`

`MY_NUMBER`


The program can be run in the terminal, from within the repo, by calling

`ruby ./lib/order_for_terminal.rb`

