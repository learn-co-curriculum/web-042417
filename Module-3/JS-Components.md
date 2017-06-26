---
title: The Era of Components
type: lesson
duration: "1hr 30min"
creator:
  name: Tony
  city: NYC
competencies: JS Components
---

# JavaScript Components 
We already created a ToDo app using the power of jQuery. Now lets evolve our knowledge and create the same application with JS Classes in an OO manner creating what is called "Components".


### Objectives
*After this lesson, students will be able to:*

- Web Components & reusability
- Presentational vs Container components
- Create class the renders html
- Create a container that holds those elements
- Event Handlers in classes
**BONUS**

- HTML component library



### Review Questions
**Q:** Does JS have classes? 

**Q:** What is an Event Handler? 


## Web Components

>The dictionary definition of a component is "A part or element of a larger whole".


Well… Web Components are not actually a new thing in web development. Basically, it is a concept of reusable widgets (components) which contain an html template and can be imported in different files and used as normal HTML tags. The main intention of its creators is to make Web Components a browser standard so they won’t need any external libraries to work.

Unfortunately they are still not supported by all browsers so there is a need to use a set of polyfills – they are called webcomponentsjs

Advantages:

1. **Consistency** - Implementing reusable components helps keep design consistent and can provide clarity in organising code.
2. **Maintainability** - A set of well organised components can be quick to update, and you can be more confident about which areas will and won't be affected.
3. **Scalability** - Having a library of components to implement can make for speedy development, and ensuring components are properly namespaced helps to avoid styles and functionality leaking into the wrong place as projects scale.


Rules:

1. **Independent** - Components should be able to be used on their own and rely on only a limited set of dependencies. They should be built so they don't 'leak' or cross-over into other components.
2. **Clearly defined** - Useful but limited scope - E.g a 'button' component + a 'search box' component is better than a 'navbar' component, but a search button and search input shouldn't be split up into two separate components if they'll never be used independently.
3. **Encapsulated** - Components should 'wrap up' their functionality within themselves and provide set ways of implementation. E.g a button component could expose "size" and "colour" options.
4. **Reusable** - Components are often built with reusability in mind, although they may initially only be implemented once.


## Component Architecture


### Container components

>A container does data fetching and then renders its corresponding sub-component. That’s it.


You’ll find your components much easier to reuse and reason about if you divide them into two categories. I call them Container and Presentational components* but I also heard Fat and Skinny, Smart and Dumb, Stateful and Pure, Screens and Components, etc. These all are not exactly the same, but the core idea is similar.

- Are concerned with how things work.
- May contain both presentational and container components** inside but usually don’t have any DOM markup of their own except for some wrapping divs, and never have any styles.
- Provide the data and behavior to presentational or other container components.
- Call Flux actions and provide these as callbacks to the presentational components.
- Are often stateful, as they tend to serve as data sources.
- Are usually generated using higher order components such as connect() from React Redux, createContainer() from Relay, or Container.create() from Flux Utils, rather than written by hand.

>Examples: UserPage, FollowersSidebar, StoryContainer, FollowedUserList.


### Presentational components

- Are concerned with how things look.
- May contain both presentational and container components** inside, and usually have some DOM markup and styles of their own.
- Often allow containment via this.props.children.
- Have no dependencies on the rest of the app, such as Flux actions or stores.
- Don’t specify how the data is loaded or mutated.
- Receive data and callbacks exclusively via props.
- Rarely have their own state (when they do, it’s UI state rather than data).
- Are written as functional components unless they need state, lifecycle hooks, or performance optimizations.
Examples: Page, Sidebar, Story, UserInfo, List.



#### Benefits of this architecture

- Better separation of concerns. You understand your app and your UI better by writing components this way.
- Better reusability. You can use the same presentational component with completely different state sources, and turn those into separate container components that can be further reused.
- Presentational components are essentially your app’s “palette”. You can put them on a single page and let the designer tweak all their variations without touching the app’s logic. You can run screenshot regression tests on that page.
- This forces you to extract “layout components” such as Sidebar, Page, ContextMenu and use this.props.children instead of duplicating the same markup and layout in several container components.

![](https://cdn-images-1.medium.com/max/800/1*inU9OmAFSDYKFm8pstsCDw.png)


<<<<<<< HEAD
## Live Coding 
=======
##Live Coding
>>>>>>> 99ac2a6f4178b6093546815237b0083c53aeb558
