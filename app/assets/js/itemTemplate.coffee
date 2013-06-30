itemSplitter = '<itemsplitter>'

itemTemplate =
"<div class='item'>
  <a href='{{:affiliateURL}}'>
    <div class='img'>
    {{if imageURL }}
      <img src='{{:imageURL.small}}'>
    {{else}}
      <img src='../images/no-image.jpg'>
    {{/if}}
    </div>
    <div class='info'>
      <div class='title'>{{>title}}</div>
      {{if iteminfo.keyword && iteminfo.keyword.length }}
        <div class='keyword'>
          {{for iteminfo.keyword}}
            <div>{{>name}}</div>
          {{/for}}
        </div>
      {{/if}}
    </div>
  </a>
</div>
#{itemSplitter}"

window.itemSplitter = itemSplitter
window.itemTemplate = itemTemplate
