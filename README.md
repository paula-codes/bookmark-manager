1. Show a list of bookmarks
  As a user,
  So I can choose a bookmark
  I want to see a list of all the bookmarks

  Nouns           Owner       Property
  -------------------------------------
  user            x
  a bookmark      x

  Verbs                     Owned by
  ------------------------------------
  list_all_bookmarks         user

  Verbs                   Property it reads/changes
  -----------------------------------------------------
  list_all_bookmarks           reading bookmarks

  class: Bookmark
  properties: title

  class: User
  properties: name, bookmarks
  action: list_all_bookmarks



  

2. Add new bookmarks
Delete bookmarks
Update bookmarks
Comment on bookmarks
Tag bookmarks into categories
Filter bookmarks by tag
Users are restricted to manage only their own bookmarks