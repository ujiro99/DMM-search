itemTemplate =
"<div class='item'>
  <a href='{{:affiliateURL}}'>
    <div class='img'>
    {{if imageURL }}
      <img src='{{:imageURL.small}}'>
    {{else}}
      <img src='../images/no-image.png'>
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
#"

window.itemTemplate = itemTemplate
