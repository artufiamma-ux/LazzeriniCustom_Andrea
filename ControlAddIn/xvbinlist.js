document.body.innerHTML = `
<div id="cardsExt">Loading</div> <div id="cards" > ... </div>
`;
window.ClearCards = function ()
{
    alert('ClearCards');
    document.getElementById('cards').innerHTML = 'ECCOLO';
};

window.AddCard =
function(
    recordNo,
    no,
    description,
    uom,
    qty)
{
    alert('AAAAggiungo card: ' + recordNo + ' - ' + no + ' - ' + description + ' - ' + uom + ' - ' + qty);
    let zebraClass =
        recordNo % 2 === 0
            ? 'even'
            : 'odd';

    let typeClass =
        type === 'BIN'
            ? 'type-bin'
            : 'type-item';
    document
        .getElementById('cards').innerHTML = 'BOOOO';
alert(document.getElementById('cards').innerText)
    addCard(
        recordNo,
        no,
        description,
        uom,
        qty);
};

window.move = function(no)
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'MoveRequested',
        [no]
    );
};
window.AddCardContainer = function (
    title,
    type
) {

    let typeClass =
        type === 'BIN'
            ? 'type-bin'
            : 'type-item';
    document
        .getElementById('cardsExt')
        .insertAdjacentHTML(
            'beforebegin',
`
    <div id="cardsHeader" class="mob-header ${typeClass}">
        ${title}
    </div>
    
 `   
        );};

function addCard (
    recordNo,
    no,
    description, 
    uom,
    qty
) {

    let zebraClass =
        recordNo % 2 === 0
            ? 'even'
            : 'odd';

    let typeClass =
        type === 'BIN'
            ? 'type-bin'
            : 'type-item';
    alert('Aggiungo card: ' + recordNo + ' - ' + no + ' - ' + description + ' - ' + uom + ' - ' + qty);

    document
        .getElementById('cards')
        .insertAdjacentHTML(
            'beforeend',
`
<div class="mob-card ${zebraClass}">

    <div class="mob-desc">
        ${no} - ${description}
    </div>

    <div class="mob-qty">
        ${qty} ${uom}
    </div>

    <button
        class="mob-btn"
        onclick="moveCard(${recordNo})">

        ↔️ SPOSTA

    </button>

</div>
`
        );
};

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
    'ControlReady',
    []
);