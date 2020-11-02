# ProductsEditor

NOTE:
This project requires Docker compose and a specific repo of files to run its APIs.
As of right now the project does not include these files.

Made during a boring weekend in the middle of a pandemic.

The project is a simple displayer app of products, with the possibility to add newer ones, or update and even delete pre-existing ones.
The app uses a VIPER architecture, precisely is layered in Services, Interactors, Presenters, ViewState, ViewControllers/Views and a Coordinator.

The View is responsible only for the visualization logic, so how things are displayed, while the Presenter is responsible for the presentation logic, so what is displayed.

The Presenter also covers the responsibility of "serving" the user interactions captured by the view, and contacting the Interactor whenever it needs it to trigger some business logic, while also making the view react accordingly through the use of protocols or ViewStates.
ViewStates are just simple structures, that are used to update the current state of the view. In this way the view is like an "atomic" structure itself, that refreshes just as the Presenter calls for the ViewState update.

The Interactor is in fact the business logic layer, is mostly a pure functional class, and is responsible for handling the Models, the real entities of the application, that are translated in ViewStates, and that are passed between modules, or fetched from the services responses.

The Coordinator is instead the navigation handler of the app, each module is composed by an Interactor a View and a Presenter, but the Coordinator allows encapsulation and information hiding between each modules, in a way in which they can have models for input (so that the modules are actually evolving according to the state of these models), and can give models in outpt, without knowing which is the next module and how it will be presented.
This is permitted through the injection of closures in the modules from the Coordinator, which then composes the next module, and hanldes how they are displayed.

I like this idea of having each module as a separate system which has model as inputs and other models as outputs, it also makes testing way more easy, and provides a good amount of separation of responsibilities.

All layers may interact with each other only through the use of protocols, this allows for a better encapsulation, and provides a very easy way to implement mock classess used for testing.
The only layer that sees the concrete implementation of the protocols is the Coordinator which for this simple projects also acts as my Dependency Injector.

These products are fetched from a REST API, and paginated in bulks, every time the user reaches the end of the products list.

Is possible in the first to view to tap on any of the products to display a detail view that shows all the linked images of the product, the name, the merchant, and the possibility to directly access via browser the shopping site.

However new products can be added, and the pre-existing ones can be modified or even deleted, and the same goes for the images linked by a product.
I don't want to go too much in detail on how the functionalities are accessed, since I would like to have feedback on the UX, and I feel that "spoiling" how does the application work would make the evaluation of the UX's immediacy less reliable.

The projects also feature some Unit Testing for the fetching functionalit, and full dark mode support.

I feel it has everything it should have, but with more time I would have for sure tried to implemented a more seamless paging system, some more UI testing, and why not, some more eye candies for the UI.

Leave me some feedback, that would be very appreciated.
