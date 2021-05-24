# hepsiexpress
iOS Developer case study project for hepsiburada.com - hepsiexpress.

[iOS Case Study.pdf](https://github.com/abdurrahmansanli/hepsiexpress/files/6524123/iOS.Case.Study.pdf)

```Latest stable branch: development```

## Technologies being used:
- **Alamofire**: REST API tool.
- **ObjectMapper**: Makes sense of JSON objects. (serialization)
- **ReactiveKit**: Core of Bond.
- **Bond**: Easy to use reactive framework for easier MVVM implementation.
- **Kingfisher**: Fetch & cache images.
- **SnapKit**: Autolayout from UI. Learn more here in my blog: 
https://medium.com/appcent/swift-5-autolayout-in-code-in-depth-tutorial-best-practices-snapkit-examples-1fd8be6b55ef

## Challenges:

### Pairing Campaign objects:

There are two types of Campaign objects: Hot Deal & Banner. Client asks to pair these objects until there's no possible pairs to make so that we can add the rest at the end of the array list. This is done inside ```ObjectPairingService```

### Testing Campaign object pairs:

Provided API did not cover cases where Campaign objects couldn't be paired so we had to test those cases as well. These cases are covered by tests in ```CampaignsSpec``` along with an API stub ```CampaignsAPIStub```.

### Banner photo ratios:

Banner widths (approx. 400) are smaller than most of the device widths (approx. 414). If we would pin edges of banner photos to device edges; we would have to strect the images out. In order to prevent this; ```BannerTableViewCell``` calculates banner layouts in such a way where:
- Banners smaller than screen width will sit in the center X axis of the screen with their available width.
- Banners bigger than screen width will accept screen width as their actual width.
- Each banner will keep its calculated width-height ratio in any case.

### Ticking timers:

Hot deal timers should all tick at the sametime. This prevents their implementation in individual cells. If we did apply the timers in each cell individually; they would initialize in different milisecond intervals. Difference in their millisecond initializations would look each timer to tick in a different time phase. In order to prevent this; we've implemented our timer update mechanism within the tableView class itself ```CampaignsViewModel``` where timers for all visible cells are updated once every second.

## Things we can improve:

- Skeleton loading as initial loading & along with pull to refresh; instead of single UIActivityIndicator spinning in the middle.
- Fetched images can fade in rather than appearing as soon as they are fetched.
- Error handing for API calls.
- UI improvements.
