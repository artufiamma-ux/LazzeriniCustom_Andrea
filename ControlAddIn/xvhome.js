document.body.innerHTML = `
<div id="xv-home">
    <button id="pick-sped" class="pick-sped">
        📦 PRELIEVI SPEDIZIONI
    </button>
    <button id="pick-prod" class="pick-prod">
        🏭 PRELIEVI PRODUZIONE
    </button>
    <button id="magazzino" class="magazzino">
        🏬 MAGAZZINO
    </button>
    <button id="stampa-etichetta" class="stampa-etichetta">
        🖨️ STAMPA ETICHETTA
    </button>
    <button id="dividi-scatole" class="dividi-scatole">
        ✂️ DIVIDI SCATOLE
    </button>
    <button id="compatta-scatole" class="compatta-scatole">
        📚 COMPATTA SCATOLE
    </button>
    <button id="sposta-articolo" class="sposta-articolo">
        ↔️ SPOSTA ARTICOLO
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

document.getElementById('magazzino').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['MAGAZZINO']
    );
});

document.getElementById('stampa-etichetta').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['STAMPA_ETICHETTA']
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

document.getElementById('sposta-articolo').addEventListener('click', function () {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'ActionSelected',
        ['SPOSTA_ARTICOLO']
    );
});
