document.body.innerHTML = `
<div id="xv-home">
    <button id="articolo" class="articolo">
        🏬 MAGAZZINO
    </button>
    <button id="pick-sped" class="pick-sped">
        📦 PRELIEVI SPEDIZIONI
    </button>
    <button id="pick-prod" class="pick-prod">
        🏭 PRELIEVI PRODUZIONE
    </button>
    <button id="dividi-scatole" class="dividi-scatole">
        ✂️ DIVIDI SCATOLE
    </button>
    <button id="compatta-scatole" class="compatta-scatole">
        📚 COMPATTA SCATOLE
    </button>
</div>
`;

document.getElementById('pick-sped').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['PRELIEVI_SPED']
    );
});
document.getElementById('pick-prod').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['PRELIEVI_PROD']
    );
});

document.getElementById('articolo').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['ARTICOLO']
    );
});


document.getElementById('dividi-scatole').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['DIVIDI_SCATOLE']
    );
});

document.getElementById('compatta-scatole').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['COMPATTA_SCATOLE']
    );
});

