// Interfaz "Pepo Banned" (boot Apple + key gate + panel) construida por el
// usuario fuera de Xcode. Se embebe tal cual (recortando solo las keys de
// prueba) y corre dentro de un WKWebView — ver PepoSkinWebView.swift.
//
// Placeholders reemplazados en tiempo de ejecucion por Swift:
//   __START_MODE__     -> "boot" | "skin"
//   __OS_LABEL__        -> p.ej. "iOS 18.1"  (AppInfo.osVersion)
//   __OS_BUILD_LABEL__  -> p.ej. "iOS 18.1 · 22B83" (version + build real)
//
// La tarjeta crece (mismo diseño) en iPad via @media en el <head>; no
// hace falta nada especial desde Swift para eso.
enum PepoSkinHTML {
    static let source = #"""
<!DOCTYPE html>
<html lang="es" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>EXTERNAL // __OS_LABEL__ // Pepo Banned</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
  <script>
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          fontFamily: {
            sans: ['Inter', 'sans-serif'],
            mono: ['JetBrains Mono', 'monospace'],
          },
          colors: {
            crimson: {
              400: '#ff4d5e',
              500: '#ff2a3c',
              600: '#e11d48',
              700: '#be123c',
              900: '#4c0519',
              950: '#24050b',
            },
            obsidian: {
              950: '#060709',
              900: '#0d0e12',
              850: '#13151c',
              800: '#191c24',
              700: '#242834',
            }
          }
        }
      }
    }
  </script>
  <style>
    * {
      box-sizing: border-box;
      -webkit-tap-highlight-color: transparent;
    }
    body {
      background-color: #030304;
      color: #f4f4f5;
      font-family: 'Inter', sans-serif;
      margin: 0;
      padding: 0;
      overflow-x: hidden;
    }
    ::-webkit-scrollbar {
      width: 4px;
      height: 4px;
    }
    ::-webkit-scrollbar-track {
      background: rgba(255, 255, 255, 0.02);
    }
    ::-webkit-scrollbar-thumb {
      background: rgba(255, 42, 60, 0.35);
      border-radius: 9999px;
    }
    .no-scrollbar::-webkit-scrollbar {
      display: none;
    }
    .no-scrollbar {
      -ms-overflow-style: none;
      scrollbar-width: none;
    }
    .glow-red {
      box-shadow: 0 0 24px rgba(255, 42, 60, 0.36);
    }
    .glow-red-soft {
      box-shadow: 0 0 16px rgba(255, 42, 60, 0.18);
    }
    .glow-white {
      box-shadow: 0 0 22px rgba(255, 255, 255, 0.25);
    }
    .glow-white-soft {
      box-shadow: 0 0 14px rgba(255, 255, 255, 0.14);
    }
    .glow-purple-soft {
      box-shadow: 0 0 18px rgba(139, 92, 246, 0.32);
    }
    .glow-orange-soft {
      box-shadow: 0 0 18px rgba(249, 115, 22, 0.32);
    }
    .glass-card {
      background: linear-gradient(180deg, rgba(21, 23, 30, 0.95) 0%, rgba(13, 14, 19, 0.98) 100%);
      border: 1px solid rgba(255, 255, 255, 0.075);
    }
    .glass-subcard {
      background: rgba(9, 10, 14, 0.85);
      border: 1px solid rgba(255, 255, 255, 0.055);
    }
    @keyframes appleBootFadeOut {
      0% { opacity: 1; }
      100% { opacity: 0; pointer-events: none; }
    }
    .boot-fade-out {
      animation: appleBootFadeOut 0.45s ease forwards;
    }
  </style>
  <!-- iPad: misma tarjeta y mismo diseño, solo más grande. Se activa por
       ancho de viewport (>=768pt), así que también crece en iPhone en
       landscape grande, que es lo correcto. -->
  <style>
    @media (min-width: 768px) {
      html { font-size: 118%; }
      #app-shell { max-width: min(860px, 92vw); }
    }
    @media (min-width: 1024px) {
      html { font-size: 128%; }
      #app-shell { max-width: min(960px, 86vw); }
    }
  </style>
</head>
<body class="min-h-screen flex justify-center bg-[#020203] selection:bg-crimson-500 selection:text-white">

  <!-- CONTENEDOR PRINCIPAL ESTILO APP MÓVIL -->
  <div id="app-shell" class="relative w-full max-w-[440px] min-h-screen bg-obsidian-950 border-x border-white/[0.06] flex flex-col justify-between overflow-hidden shadow-2xl">

    <!-- =====================================================================
         PANTALLA 0: APPLE BOOT SCREEN (CARGA INICIAL ANTES DE KEY GATE)
         ===================================================================== -->
    <section id="apple-boot-screen" class="fixed inset-0 z-[60] bg-black flex flex-col items-center justify-center select-none">
      <div class="flex flex-col items-center justify-center w-full max-w-[260px] px-6">
        <!-- Logotipo oficial de Apple en blanco puro -->
        <svg class="h-[72px] w-auto text-white mb-10" viewBox="0 0 384 512" fill="currentColor" aria-label="Apple Logo" role="img">
          <path d="M318.7 268.7c-.2-36.7 16.4-64.4 50-84.8-18.8-26.9-47.2-41.7-84.7-44.6-35.5-2.8-74.3 20.7-88.5 20.7-15 0-49.4-19.7-76.4-19.7C63.3 141.2 4 184.8 4 273.5q0 39.3 14.4 81.2c12.8 36.7 59 126.7 107.2 125.2 25.2-.6 43-17.9 75.8-17.9 31.8 0 48.3 17.9 76.4 17.9 48.6-.7 90.4-82.5 102.6-119.3-65.2-30.7-61.7-90-61.7-91.9zm-56.6-164.2c27.3-32.4 24.8-61.9 24-72.5-24.1 1.4-52 16.4-67.9 34.9-17.5 19.8-27.8 44.3-25.6 71.9 26.1 2 49.9-11.4 69.5-34.3z"/>
        </svg>

        <!-- Barra de progreso horizontal delgada -->
        <div class="w-40 h-[3px] bg-[#2a2a2a] rounded-full overflow-hidden">
          <div id="apple-boot-bar" class="h-full w-0 bg-white rounded-full transition-all duration-75 ease-linear"></div>
        </div>
      </div>
    </section>

    <!-- =====================================================================
         PANTALLA 1: INTERFAZ DE KEY / DESBLOQUEO (KEY GATE)
         ===================================================================== -->
    <section id="key-gate-screen" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-[#040406]/95 backdrop-blur-xl p-4">
      <div class="w-full max-w-[400px] glass-card rounded-3xl p-6 border border-crimson-500/35 shadow-[0_0_55px_rgba(255,42,60,0.18)] relative overflow-hidden">
        <!-- Acentos ambientales -->
        <div class="absolute -top-24 -right-24 w-48 h-48 bg-crimson-500/15 rounded-full blur-3xl pointer-events-none"></div>
        <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-white/5 rounded-full blur-3xl pointer-events-none"></div>

        <!-- === AQUÍ VA TU INTERFAZ DE KEYS PERSONALIZADA === -->
        <!-- Puedes reemplazar el contenido interno de #custom-key-ui-slot con tu propia UI de Keys.
             Cuando tu interfaz valide una key, simplemente llama a: window.unlockMainInterface(keyUsada) -->
        <div id="custom-key-ui-slot" class="relative z-10">
          <div class="flex items-center justify-between mb-6">
            <div class="flex items-center gap-3">
              <div class="w-11 h-11 rounded-2xl bg-crimson-500/15 border border-crimson-500/45 flex items-center justify-center text-crimson-500 glow-red-soft">
                <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4">
                  <path d="M4 9c5-2 11-2 16 0" stroke-linecap="round"/>
                  <path d="M6 13c4-1.5 8-1.5 12 0" stroke-linecap="round"/>
                  <path d="M8 17c2.5-1 5.5-1 8 0" stroke-linecap="round"/>
                </svg>
              </div>
              <div>
                <h1 class="text-base font-black tracking-[0.2em] text-white">EXTERNAL</h1>
                <p class="text-[11px] font-mono text-crimson-400">__OS_LABEL__ // Pepo Banned</p>
              </div>
            </div>
            <span class="px-2.5 py-1 rounded-full text-[10px] font-mono font-bold tracking-wider bg-white text-black">
              KEY GATE
            </span>
          </div>

          <div class="mb-5">
            <h2 class="text-lg font-extrabold text-white tracking-tight">Verificación de Licencia</h2>
            <p class="text-xs text-zinc-400 mt-1 leading-relaxed">
              Introduce tu key de acceso para entrar al panel <span class="text-white font-semibold">Pepo Banned</span>.
            </p>
          </div>

          <div class="space-y-3">
            <div>
              <label for="key-input" class="block text-[10px] font-mono uppercase tracking-widest text-zinc-400 mb-1.5">
                ACCESS KEY
              </label>
              <div class="relative">
                <input
                  id="key-input"
                  type="text"
                  placeholder="PEPO-2026-VIP"
                  autocomplete="off"
                  class="w-full bg-obsidian-900/95 border border-white/15 focus:border-crimson-500 focus:ring-2 focus:ring-crimson-500/20 rounded-2xl px-4 py-3.5 text-sm font-mono text-white placeholder-zinc-600 outline-none transition uppercase"
                />
              </div>
            </div>

            <div id="key-feedback" class="hidden text-xs font-mono px-3 py-2 rounded-xl border"></div>

            <button
              id="key-unlock-btn"
              type="button"
              onclick="validateKeyInput()"
              class="w-full py-3.5 px-4 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 hover:from-crimson-500 hover:to-crimson-400 active:scale-[0.99] text-white font-black text-sm tracking-wider uppercase glow-red transition flex items-center justify-center gap-2 cursor-pointer disabled:cursor-not-allowed"
            >
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4">
                <rect x="3" y="11" width="18" height="11" rx="2"/>
                <path d="M7 11V7a5 5 0 0 1 9.9-1"/>
              </svg>
              <span data-btn-label>DESBLOQUEAR PANEL</span>
            </button>
          </div>
        </div>
        <!-- === FIN ZONA DE INTERFAZ DE KEYS PERSONALIZADA === -->
      </div>
    </section>

    <!-- =====================================================================
         PANTALLA 2: APLICACIÓN PRINCIPAL (4 PESTAÑAS + SETTINGS MODAL)
         ===================================================================== -->
    <div id="main-panel" class="hidden flex-1 flex flex-col pb-24">

      <!-- =====================================
           PESTAÑA 1: STAGE
           ===================================== -->
      <main id="tab-stage" class="tab-view flex-1 flex flex-col px-4 pt-4 space-y-3.5">
        <!-- Header Global -->
        <header class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <div class="w-11 h-11 rounded-2xl bg-crimson-500/15 border border-crimson-500/45 flex items-center justify-center text-crimson-500 glow-red-soft">
              <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4">
                <path d="M4 9c5-2 11-2 16 0" stroke-linecap="round"/>
                <path d="M6 13c4-1.5 8-1.5 12 0" stroke-linecap="round"/>
                <path d="M8 17c2.5-1 5.5-1 8 0" stroke-linecap="round"/>
              </svg>
            </div>
            <div>
              <h1 class="text-base font-black tracking-[0.22em] text-white leading-tight">EXTERNAL</h1>
              <p class="text-xs font-mono text-crimson-400 font-medium">__OS_LABEL__ // Pepo Banned</p>
            </div>
          </div>
          <button onclick="openSettings()" aria-label="Settings" class="w-11 h-11 rounded-2xl glass-card hover:border-white/25 flex items-center justify-center text-zinc-300 hover:text-white transition active:scale-95 cursor-pointer">
            <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="3"/>
              <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 1 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 1 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 1 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9c.26.604.852.997 1.51 1H21a2 2 0 1 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/>
            </svg>
          </button>
        </header>

        <!-- Visor 3D del Personaje + Botones Flotantes BODY (Rojo) / WEAPON (Blanco) -->
        <div class="relative h-[265px] rounded-3xl bg-gradient-to-b from-obsidian-900/45 via-obsidian-900/15 to-transparent border border-white/[0.04] flex items-center justify-center overflow-hidden select-none">
          <div id="stage-aura" class="absolute left-1/3 top-1/2 -translate-x-1/2 -translate-y-1/2 w-44 h-44 rounded-full bg-crimson-500/20 blur-3xl transition-colors duration-500"></div>

          <!-- Canvas 3D Rotable -->
          <canvas id="character-canvas" class="w-full h-full cursor-grab active:cursor-grabbing"></canvas>

          <!-- Botones Flotantes Apilados a la Derecha -->
          <div class="absolute right-3 top-1/2 -translate-y-1/2 flex flex-col gap-2.5 z-10">
            <!-- BODY (Rojo cuando activo) -->
            <button
              id="float-btn-body"
              onclick="selectStageSlot('BODY')"
              class="w-[144px] p-2.5 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 text-white border border-crimson-400/50 glow-red flex items-center gap-2.5 text-left transition-all cursor-pointer"
            >
              <div class="w-8 h-8 rounded-xl bg-black/25 flex items-center justify-center shrink-0">
                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="currentColor">
                  <circle cx="12" cy="5" r="2.5"/>
                  <path d="M16 9H8a1 1 0 0 0-1 1v5h2v6h6v-6h2v-5a1 1 0 0 0-1-1z"/>
                </svg>
              </div>
              <div class="min-w-0">
                <div class="text-xs font-black tracking-wider leading-none">BODY</div>
                <div id="float-sub-body" class="text-[9px] font-mono uppercase opacity-90 mt-1 truncate">NORMAL</div>
              </div>
            </button>

            <!-- WEAPON (Blanco cuando activo) -->
            <button
              id="float-btn-weapon"
              onclick="selectStageSlot('WEAPON')"
              class="w-[144px] p-2.5 rounded-2xl glass-card hover:border-white/30 text-zinc-200 flex items-center gap-2.5 text-left transition-all cursor-pointer"
            >
              <div class="w-8 h-8 rounded-xl bg-white/10 text-white flex items-center justify-center shrink-0">
                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                  <circle cx="12" cy="12" r="7"/>
                  <line x1="12" y1="2" x2="12" y2="6"/>
                  <line x1="12" y1="18" x2="12" y2="22"/>
                  <line x1="2" y1="12" x2="6" y2="12"/>
                  <line x1="18" y1="12" x2="22" y2="12"/>
                </svg>
              </div>
              <div class="min-w-0">
                <div class="text-xs font-black tracking-wider leading-none">WEAPON</div>
                <div id="float-sub-weapon" class="text-[9px] font-mono uppercase text-zinc-400 mt-1 truncate">NORMAL</div>
              </div>
            </button>
          </div>
        </div>

        <!-- Bottom Sheet / Panel Inferior de Control -->
        <div class="glass-card rounded-3xl p-4 space-y-3.5 border border-white/[0.08]">
          <!-- Selector Superior Dividido BODY / WEAPON -->
          <div class="grid grid-cols-2 gap-2.5">
            <button
              id="card-slot-body"
              onclick="selectStageSlot('BODY')"
              class="p-3 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 text-white border border-crimson-400/50 glow-red-soft flex items-center justify-between text-left transition cursor-pointer"
            >
              <div class="flex items-center gap-2">
                <svg class="w-4 h-4 shrink-0" viewBox="0 0 24 24" fill="currentColor">
                  <circle cx="12" cy="5" r="2.5"/>
                  <path d="M16 9H8a1 1 0 0 0-1 1v5h2v6h6v-6h2v-5a1 1 0 0 0-1-1z"/>
                </svg>
                <div>
                  <div class="text-[11px] font-black tracking-wider">BODY</div>
                  <div id="slot-status-body" class="text-[9px] font-mono opacity-90">READY</div>
                </div>
              </div>
              <span class="w-2 h-2 rounded-full bg-white"></span>
            </button>

            <button
              id="card-slot-weapon"
              onclick="selectStageSlot('WEAPON')"
              class="p-3 rounded-2xl bg-obsidian-900/90 border border-white/10 text-zinc-300 flex items-center justify-between text-left transition cursor-pointer"
            >
              <div class="flex items-center gap-2">
                <svg class="w-4 h-4 text-white shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                  <circle cx="12" cy="12" r="7"/>
                  <circle cx="12" cy="12" r="2"/>
                </svg>
                <div>
                  <div class="text-[11px] font-black tracking-wider">WEAPON</div>
                  <div id="slot-status-weapon" class="text-[9px] font-mono text-zinc-400">READY</div>
                </div>
              </div>
              <span class="w-2 h-2 rounded-full bg-zinc-600"></span>
            </button>
          </div>

          <!-- ACTIVE PAYLOAD Header -->
          <div class="flex items-center justify-between">
            <div>
              <div class="text-[10px] font-mono tracking-[0.16em] text-zinc-500 uppercase">ACTIVE PAYLOAD</div>
              <div id="active-payload-title" class="text-lg font-black tracking-wide text-white mt-0.5">PECHO · NORMAL</div>
            </div>
            <span id="armed-badge" class="px-3 py-1.5 rounded-xl bg-crimson-500/15 border border-crimson-500/40 text-crimson-400 text-[11px] font-mono font-bold tracking-wider">
              • ARMED
            </span>
          </div>

          <!-- Fila de 3 Métricas: SIZE / DIGEST / SLOT -->
          <div class="grid grid-cols-3 gap-2 py-2.5 px-3 rounded-2xl bg-obsidian-950/80 border border-white/[0.05]">
            <div>
              <div class="text-[9px] font-mono text-zinc-500 uppercase">SIZE</div>
              <div id="payload-size" class="text-xs font-mono font-bold text-zinc-200 mt-0.5">46 KB</div>
            </div>
            <div>
              <div class="text-[9px] font-mono text-zinc-500 uppercase">DIGEST</div>
              <div id="payload-digest" class="text-xs font-mono font-bold text-zinc-200 mt-0.5">501CFB64</div>
            </div>
            <div>
              <div class="text-[9px] font-mono text-zinc-500 uppercase">SLOT</div>
              <div id="payload-slot" class="text-xs font-mono font-bold text-crimson-400 mt-0.5">BODY</div>
            </div>
          </div>

          <!-- Carrusel Horizontal Deslizable de Payloads -->
          <div id="payload-chips-container" class="flex items-center gap-2 overflow-x-auto no-scrollbar py-0.5">
            <!-- Generado por JS -->
          </div>

          <!-- Botón Principal INJECT / RE-INJECT + Restore (↩) -->
          <div class="flex items-center gap-2.5 pt-0.5">
            <button
              id="btn-stage-inject"
              onclick="triggerStageInject()"
              class="flex-1 py-3.5 px-4 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 hover:from-crimson-500 hover:to-crimson-400 active:scale-[0.99] text-white glow-red flex items-center justify-between transition cursor-pointer"
            >
              <div class="flex items-center gap-3">
                <svg class="w-5 h-5 fill-current" viewBox="0 0 24 24">
                  <path d="M13 2L3 14h7l-1 8 10-12h-7l1-8z"/>
                </svg>
                <div class="text-left">
                  <div id="inject-btn-label" class="text-sm font-black tracking-wider leading-none">INJECT</div>
                  <div id="inject-target-sub" class="text-[11px] font-mono opacity-90 mt-1">BODY → Free Fire</div>
                </div>
              </div>
              <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4">
                <path d="M7 17L17 7M7 7h10v10" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </button>

            <button
              onclick="triggerStageRestore()"
              title="Restaurar slot"
              class="w-14 h-[54px] rounded-2xl bg-obsidian-900 hover:bg-obsidian-800 border border-white/10 flex items-center justify-center text-zinc-300 hover:text-white active:scale-95 transition cursor-pointer"
            >
              <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                <path d="M9 14L4 9l5-5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 9h10.5a5.5 5.5 0 0 1 5.5 5.5v0a5.5 5.5 0 0 1-5.5 5.5H11" stroke-linecap="round"/>
              </svg>
            </button>
          </div>
        </div>
      </main>

      <!-- =====================================
           PESTAÑA 2: ARSENAL (PATCH STUDIO)
           ===================================== -->
      <main id="tab-arsenal" class="tab-view hidden flex-1 flex flex-col px-4 pt-4 space-y-5">
        <!-- Header Patch Studio -->
        <header class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <div class="w-11 h-11 rounded-2xl bg-crimson-500/15 border border-crimson-500/45 flex items-center justify-center text-crimson-500 glow-red-soft">
              <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4">
                <path d="M4 9c5-2 11-2 16 0" stroke-linecap="round"/>
                <path d="M6 13c4-1.5 8-1.5 12 0" stroke-linecap="round"/>
                <path d="M8 17c2.5-1 5.5-1 8 0" stroke-linecap="round"/>
              </svg>
            </div>
            <div>
              <h1 class="text-base font-black tracking-[0.16em] text-white leading-tight">PATCH STUDIO</h1>
              <p class="text-[11px] font-mono text-zinc-400">FREE FIRE MAX · MOD</p>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <button onclick="showToast('Catálogo sincronizado')" class="w-9 h-9 rounded-full glass-card flex items-center justify-center text-crimson-400 text-xs cursor-pointer">●</button>
            <button onclick="showToast('Recargando módulos...')" class="w-9 h-9 rounded-full glass-card flex items-center justify-center text-zinc-300 text-xs cursor-pointer">↻</button>
            <button onclick="openSettings()" class="w-9 h-9 rounded-full glass-card flex items-center justify-center text-zinc-300 cursor-pointer">
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M4 6h16M4 12h16M4 18h16" stroke-linecap="round"/>
              </svg>
            </button>
          </div>
        </header>

        <!-- Tarjeta CONTROL DE PARCHES con Nodos Orbitales y Líneas Punteadas -->
        <div class="glass-card rounded-3xl p-4 relative overflow-hidden">
          <div class="flex items-center gap-2 text-xs font-black tracking-wider text-zinc-200 uppercase mb-2">
            <span class="w-2 h-2 rounded-full bg-crimson-500"></span>
            CONTROL DE PARCHES
          </div>

          <div class="relative h-[230px] flex items-center justify-center select-none">
            <!-- Líneas orbitales y punteadas SVG -->
            <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 360 230" fill="none">
              <circle cx="180" cy="115" r="82" stroke="rgba(255,255,255,0.06)" stroke-dasharray="4 4"/>
              <line x1="180" y1="36" x2="180" y2="75" stroke="rgba(249,115,22,0.45)" stroke-dasharray="3 3"/>
              <line x1="255" y1="88" x2="210" y2="96" stroke="rgba(255,255,255,0.45)" stroke-dasharray="3 3"/>
              <line x1="105" y1="115" x2="152" y2="115" stroke="rgba(255,42,60,0.55)" stroke-dasharray="3 3"/>
              <line x1="180" y1="194" x2="180" y2="155" stroke="rgba(168,85,247,0.45)" stroke-dasharray="3 3"/>
            </svg>

            <!-- Personaje Táctico Central -->
            <svg class="h-48 w-36 relative z-10 overflow-visible" viewBox="0 0 120 200" fill="none">
              <ellipse cx="60" cy="186" rx="34" ry="7" fill="rgba(255,42,60,0.2)"/>
              <path d="M48 16L44 4L54 14M72 16L76 4L66 14" stroke="#ff2a3c" stroke-width="2.2" stroke-linecap="round"/>
              <circle cx="60" cy="28" r="13" fill="#171a24" stroke="#475569" stroke-width="2"/>
              <path d="M54 27h4M62 27h4" stroke="#ffffff" stroke-width="2" stroke-linecap="round"/>
              <path d="M40 46h40l6 46H34l6-46z" fill="#141720" stroke="#3f3f46" stroke-width="2"/>
              <path d="M38 48L22 92l8 4 10-34M82 48l16 44-8 4-10-34" fill="#141720" stroke="#3f3f46" stroke-width="2"/>
              <path d="M42 92l-4 82h14l8-56 8 56h14l-4-82" fill="#141720" stroke="#3f3f46" stroke-width="2"/>
              <!-- Marcador animado: se mueve/agranda según la opción (pecho, cuello, drag, balas mágicas) -->
              <rect id="arsenal-marker" x="48" y="56" width="24" height="22" rx="0" fill="#ff2a3c" fill-opacity="0.2" stroke="#ff2a3c" stroke-width="1.6" style="filter: drop-shadow(0 0 4px rgba(255,42,60,0.7))"/>
            </svg>

            <!-- 4 Nodos Orbitales Interactivos -->
            <button onclick="armOrbitalPatch('DRAG')" class="z-20 absolute top-2 left-1/2 -translate-x-1/2 px-3 py-1.5 rounded-full bg-obsidian-950/95 border border-orange-500/40 hover:border-orange-400 text-[11px] font-bold text-white flex items-center gap-1.5 shadow-lg cursor-pointer transition active:scale-95">
              <span class="w-4 h-4 rounded-full bg-orange-500/20 text-orange-400 flex items-center justify-center text-[9px]">↑</span>
              DRAG ›
            </button>

            <button onclick="armOrbitalPatch('CUELLO')" class="z-20 absolute top-14 right-2 px-3 py-1.5 rounded-full bg-obsidian-950/95 border border-white/30 hover:border-white text-[11px] font-bold text-white flex items-center gap-1.5 shadow-lg cursor-pointer transition active:scale-95">
              <span class="w-4 h-4 rounded-full bg-white/15 text-white flex items-center justify-center text-[9px]">⌖</span>
              CUELLO ›
            </button>

            <button onclick="armOrbitalPatch('PECHO')" class="z-20 absolute top-24 left-2 px-3 py-1.5 rounded-full bg-crimson-950/95 border border-crimson-500/60 hover:border-crimson-400 text-[11px] font-bold text-white flex items-center gap-1.5 shadow-lg glow-red-soft cursor-pointer transition active:scale-95">
              <span class="w-4 h-4 rounded-full bg-crimson-500/30 text-crimson-400 flex items-center justify-center text-[9px]">🛡</span>
              PECHO ›
            </button>

            <button onclick="armOrbitalPatch('BALAS MÁGICAS')" class="z-20 absolute bottom-2 left-1/2 -translate-x-1/2 px-3.5 py-1.5 rounded-full bg-obsidian-950/95 border border-purple-500/40 hover:border-purple-400 text-[11px] font-bold text-white flex items-center gap-1.5 shadow-lg cursor-pointer transition active:scale-95">
              <span class="w-4 h-4 rounded-full bg-purple-500/20 text-purple-400 flex items-center justify-center text-[9px]">✦</span>
              BALAS MÁGICAS ›
            </button>
          </div>

          <div class="flex items-center justify-between pt-2.5 border-t border-white/[0.06] text-[11px] font-mono">
            <span class="text-white font-bold flex items-center gap-1.5">
              <span>⛶</span> PARCHES
            </span>
            <span class="text-zinc-400 flex items-center gap-1.5">
              <span>((•))</span> ANTENA
            </span>
          </div>
        </div>

        <!-- Categorías de Parches (VISUALES 1 / NORMAL 4 / ANTENA 4) -->
        <div>
          <h2 class="text-sm font-black tracking-wider text-white uppercase">CATEGORÍAS DE PARCHES</h2>
          <p class="text-[11px] font-mono text-zinc-500 mt-0.5 mb-3">ELIGE UN TIPO DE MÓDULO</p>
          <div class="grid grid-cols-3 gap-2">
            <button onclick="setArsenalCategory('VISUALES')" id="cat-VISUALES" class="cat-btn p-3 rounded-2xl glass-card text-left flex items-center justify-between transition cursor-pointer">
              <span class="text-[10px] font-bold text-zinc-400">VISUALES</span>
              <span class="px-1.5 py-0.5 rounded-md bg-white/5 text-[10px] font-mono text-zinc-400">1</span>
            </button>
            <button onclick="setArsenalCategory('NORMAL')" id="cat-NORMAL" class="cat-btn p-3 rounded-2xl bg-white/10 border border-white/60 text-left flex items-center justify-between transition cursor-pointer glow-white-soft">
              <span class="text-[10px] font-bold text-white">NORMAL</span>
              <span class="px-1.5 py-0.5 rounded-md bg-white text-black text-[10px] font-mono font-bold">4</span>
            </button>
            <button onclick="setArsenalCategory('ANTENA')" id="cat-ANTENA" class="cat-btn p-3 rounded-2xl glass-card text-left flex items-center justify-between transition cursor-pointer">
              <span class="text-[10px] font-bold text-zinc-400">ANTENA</span>
              <span class="px-1.5 py-0.5 rounded-md bg-white/5 text-[10px] font-mono text-zinc-400">4</span>
            </button>
          </div>
        </div>

        <!-- Biblioteca de Parches -->
        <div>
          <h2 class="text-sm font-black tracking-wider text-white uppercase">BIBLIOTECA DE PARCHES</h2>
          <p class="text-[11px] font-mono text-zinc-500 mt-0.5 mb-3">SELECCIONAR · ACTIVAR · RESTAURAR</p>

          <div id="arsenal-patch-list" class="space-y-2.5">
            <!-- Renderizado dinámicamente -->
          </div>

          <p class="mt-4 text-[11px] font-mono text-zinc-500 leading-relaxed flex items-start gap-2">
            <span class="text-crimson-500 mt-0.5">🛡</span>
            Payload digests are checked before and after every write. A tampered package is rejected, never half-applied.
          </p>
        </div>
      </main>

      <!-- =====================================
           PESTAÑA 3: STATS (EXTERNAL INTEL)
           ===================================== -->
      <main id="tab-stats" class="tab-view hidden flex-1 flex flex-col px-4 pt-4 space-y-4">
        <!-- Header Stats -->
        <header class="flex items-center justify-between">
          <div>
            <div class="text-[10px] font-mono tracking-[0.2em] text-zinc-500">EXTERNAL INTEL</div>
            <h1 class="text-2xl font-black tracking-wider text-white">STATS</h1>
          </div>
          <div class="text-right">
            <div class="text-2xl font-black text-purple-400 leading-none">71</div>
            <div class="text-[9px] font-mono tracking-widest text-zinc-500 mt-1">LEVEL</div>
          </div>
        </header>

        <!-- Buscador Free Fire UID -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between text-[10px] font-mono">
            <span class="text-zinc-400 tracking-wider">FREE FIRE UID</span>
            <button onclick="resetUidInput()" class="text-crimson-400 font-bold hover:underline cursor-pointer">REMOVE</button>
          </div>
          <div class="flex gap-2">
            <div class="flex-1 flex items-center bg-obsidian-950 border border-white/10 rounded-2xl px-3.5">
              <span class="text-zinc-500 font-mono mr-2">#</span>
              <input id="ff-uid-input" type="text" value="817837121" class="w-full bg-transparent py-3 font-mono font-bold text-white text-sm outline-none" />
            </div>
            <button onclick="loadPlayerStats()" class="px-5 rounded-2xl bg-white hover:bg-zinc-200 text-black font-black text-xs tracking-wider uppercase transition active:scale-95 cursor-pointer">
              LOAD
            </button>
          </div>
          <div class="flex items-center gap-2 text-[11px] font-mono text-crimson-400">
            <span>●</span> REMEMBERED · <span id="uid-remembered-label">817837121</span>
          </div>
        </div>

        <!-- Tarjeta Perfil @SoySinfo_ff -->
        <div class="glass-card rounded-3xl p-4 flex items-center justify-between">
          <div class="flex items-center gap-3.5">
            <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-zinc-700 to-zinc-900 border border-white/15 flex items-center justify-center text-2xl font-black text-white shadow-inner">
              S
            </div>
            <div>
              <h2 id="player-name" class="text-base font-black text-white">@SoySinfo_ff</h2>
              <p id="player-uid-sub" class="text-xs font-mono text-zinc-400">UID 817837121</p>
              <div class="flex items-center gap-2.5 mt-1 text-[11px] font-mono">
                <span class="text-zinc-300 font-bold">LV 71</span>
                <span class="text-crimson-400">♥ 8,998</span>
                <span class="px-1.5 py-0.5 rounded bg-white/10 text-[9px] text-zinc-300">US</span>
              </div>
            </div>
          </div>
          <div class="flex flex-col gap-2">
            <button onclick="copyUidText()" title="Copiar UID" class="w-8 h-8 rounded-full bg-white/5 hover:bg-white/10 flex items-center justify-center text-zinc-300 text-xs cursor-pointer">⧉</button>
            <button onclick="showToast('Perfil fijado en memoria')" class="w-8 h-8 rounded-full bg-white/5 hover:bg-white/10 flex items-center justify-center text-zinc-400 text-xs cursor-pointer">✕</button>
          </div>
        </div>

        <!-- Nivel / EXP / Likes -->
        <div class="grid grid-cols-3 gap-2">
          <div class="glass-card rounded-2xl p-3">
            <div class="text-[9px] font-mono text-zinc-500">★ NIVEL</div>
            <div class="text-lg font-black text-white mt-1">71</div>
          </div>
          <div class="glass-card rounded-2xl p-3">
            <div class="text-[9px] font-mono text-zinc-500">⚡ EXP</div>
            <div class="text-xs font-black text-white mt-1.5">3,116,838 <span class="text-[9px] font-normal text-zinc-500">EXP</span></div>
          </div>
          <div class="glass-card rounded-2xl p-3">
            <div class="text-[9px] font-mono text-crimson-400">♥ LIKES</div>
            <div class="text-lg font-black text-white mt-1">8,998</div>
          </div>
        </div>

        <!-- Battle Royale & Clash Squad -->
        <div class="grid grid-cols-2 gap-2.5">
          <div class="glass-card rounded-3xl p-4 text-center space-y-2">
            <div class="text-[10px] font-mono tracking-wider text-zinc-400">BATTLE ROYALE</div>
            <div class="w-11 h-11 mx-auto rounded-2xl bg-amber-700/25 border border-amber-600/40 flex items-center justify-center text-amber-500 font-black text-lg">I</div>
            <div class="text-xs font-black tracking-wider text-white">BRONZE I</div>
            <div class="pt-2 border-t border-white/[0.06] space-y-1 text-[10px] font-mono">
              <div class="flex justify-between"><span class="text-zinc-500">PUNTOS</span><span class="text-zinc-200">1,000 points</span></div>
              <div class="flex justify-between"><span class="text-zinc-500">RANGO</span><span class="text-zinc-200">Bronze I</span></div>
              <div class="flex justify-between"><span class="text-zinc-500">PICO</span><span class="text-zinc-200"># 1,000</span></div>
            </div>
          </div>

          <div class="glass-card rounded-3xl p-4 text-center space-y-2">
            <div class="text-[10px] font-mono tracking-wider text-zinc-400">CLASH SQUAD</div>
            <div class="w-11 h-11 mx-auto rounded-2xl bg-amber-700/25 border border-amber-600/40 flex items-center justify-center text-amber-500 font-black text-lg">I</div>
            <div class="text-xs font-black tracking-wider text-white">BRONZE I</div>
            <div class="pt-2 border-t border-white/[0.06] space-y-1 text-[10px] font-mono">
              <div class="flex justify-between"><span class="text-zinc-500">PUNTOS</span><span class="text-zinc-200">0 stars</span></div>
              <div class="flex justify-between"><span class="text-zinc-500">RANGO</span><span class="text-zinc-200">Bronze I</span></div>
              <div class="flex justify-between"><span class="text-zinc-500">PICO</span><span class="text-zinc-200">0 stars</span></div>
            </div>
          </div>
        </div>

        <!-- Tabla CUENTA -->
        <div class="glass-card rounded-3xl p-4">
          <div class="text-[11px] font-mono font-bold text-zinc-300 mb-3 flex items-center gap-2">
            <span class="text-purple-400">👤</span> CUENTA
          </div>
          <div class="divide-y divide-white/[0.05] text-[11px] font-mono">
            <div class="py-2 flex justify-between gap-2"><span class="text-zinc-500">Account created</span><span class="text-zinc-200 font-bold text-right">March 17, 2019, 19:44:00 UTC</span></div>
            <div class="py-2 flex justify-between gap-2"><span class="text-zinc-500">Last login</span><span class="text-zinc-200 font-bold text-right">April 12, 2022, 06:37:40 UTC</span></div>
            <div class="py-2 flex justify-between gap-2"><span class="text-zinc-500">Account age</span><span class="text-zinc-200 font-bold text-right">7 years, 8 months and 8 days</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Game version</span><span class="text-zinc-200 font-bold">Not provided</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Season</span><span class="text-zinc-200 font-bold">54</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Badges</span><span class="text-zinc-200 font-bold">0</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Prime</span><span class="text-zinc-200 font-bold">Level 1</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Elite Pass</span><span class="text-zinc-200 font-bold">No</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Emulator</span><span class="text-zinc-200 font-bold">No</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Account type</span><span class="text-zinc-200 font-bold">1</span></div>
          </div>
        </div>

        <!-- Tabla INDICADORES -->
        <div class="glass-card rounded-3xl p-4">
          <div class="text-[11px] font-mono font-bold text-zinc-300 mb-3 flex items-center gap-2">
            <span class="text-crimson-400">◈</span> INDICADORES
          </div>
          <div class="divide-y divide-white/[0.05] text-[11px] font-mono">
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Clan</span><span class="text-zinc-200 font-bold">Not provided</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Clan ID</span><span class="text-zinc-200 font-bold">Not provided</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Clan badge</span><span class="text-zinc-200 font-bold">Not provided</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Championship team</span><span class="text-zinc-200 font-bold">Yazmin</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Team ID</span><span class="text-zinc-200 font-bold">200541822</span></div>
            <div class="py-2 flex justify-between"><span class="text-zinc-500">Team members</span><span class="text-zinc-200 font-bold">3</span></div>
          </div>
        </div>

        <!-- Conjunto Equipado (6 items) -->
        <div class="glass-card rounded-3xl p-4">
          <div class="flex items-center justify-between text-[11px] font-mono mb-3">
            <span class="font-bold text-zinc-300">👕 CONJUNTO EQUIPADO</span>
            <span class="text-purple-400 font-bold">6</span>
          </div>
          <div class="grid grid-cols-2 gap-2.5 text-xs">
            <div class="p-2.5 rounded-2xl glass-subcard flex items-center gap-2.5">
              <div class="w-9 h-9 rounded-xl bg-purple-500/15 text-purple-300 flex items-center justify-center font-bold">🎭</div>
              <div class="min-w-0">
                <div class="font-bold text-white truncate">Beach Bandana</div>
                <div class="text-[9px] font-mono text-purple-400">PELO · EPIC</div>
              </div>
            </div>
            <div class="p-2.5 rounded-2xl glass-subcard flex items-center gap-2.5">
              <div class="w-9 h-9 rounded-xl bg-zinc-500/15 text-zinc-300 flex items-center justify-center font-bold">🎨</div>
              <div class="min-w-0">
                <div class="font-bold text-white truncate">Facepaint pr...</div>
                <div class="text-[9px] font-mono text-zinc-400">ROSTRO · COMMON</div>
              </div>
            </div>
            <div class="p-2.5 rounded-2xl glass-subcard flex items-center gap-2.5">
              <div class="w-9 h-9 rounded-xl bg-amber-500/15 text-amber-300 flex items-center justify-center font-bold">🧥</div>
              <div class="min-w-0">
                <div class="font-bold text-white truncate">Arctic Blue</div>
                <div class="text-[9px] font-mono text-amber-400">MÁSCARA · LEGENDARY</div>
              </div>
            </div>
            <div class="p-2.5 rounded-2xl glass-subcard flex items-center gap-2.5">
              <div class="w-9 h-9 rounded-xl bg-white/10 text-white flex items-center justify-center font-bold">👕</div>
              <div class="min-w-0">
                <div class="font-bold text-white truncate">Chrono Top S...</div>
                <div class="text-[9px] font-mono text-zinc-300">TORSO · RARE</div>
              </div>
            </div>
            <div class="p-2.5 rounded-2xl glass-subcard flex items-center gap-2.5">
              <div class="w-9 h-9 rounded-xl bg-white/10 text-white flex items-center justify-center font-bold">👖</div>
              <div class="min-w-0">
                <div class="font-bold text-white truncate">Survivor Pants</div>
                <div class="text-[9px] font-mono text-zinc-300">PIERNAS · RARE</div>
              </div>
            </div>
            <div class="p-2.5 rounded-2xl glass-subcard flex items-center gap-2.5">
              <div class="w-9 h-9 rounded-xl bg-purple-500/15 text-purple-300 flex items-center justify-center font-bold">👟</div>
              <div class="min-w-0">
                <div class="font-bold text-white truncate">Dunk Master</div>
                <div class="text-[9px] font-mono text-purple-400">CALZADO · EPIC</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Arsenal Completo (35 Armas) -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between text-[11px] font-mono">
            <span class="font-bold text-zinc-300">⌖ ARSENAL</span>
            <span class="text-purple-400 font-bold">35 ARMAS</span>
          </div>
          <div id="stats-weapons-grid" class="space-y-3">
            <!-- Generado desde JS con las 35 armas exactas -->
          </div>
          <div class="pt-3 border-t border-white/[0.06] flex items-center justify-between text-[10px] font-mono text-zinc-500">
            <span>ACTUALIZADO 17:37 · RELAY PÚBLICO</span>
            <button onclick="loadPlayerStats()" class="text-white font-bold hover:underline cursor-pointer">ACTUALIZAR</button>
          </div>
        </div>
      </main>

      <!-- =====================================
           PESTAÑA 4: CORE (WRITE PATH)
           ===================================== -->
      <main id="tab-core" class="tab-view hidden flex-1 flex flex-col px-4 pt-4 space-y-4">
        <header class="flex items-center justify-between">
          <div>
            <div class="text-[10px] font-mono tracking-[0.2em] text-zinc-500">WRITE PATH</div>
            <h1 class="text-2xl font-black tracking-wider text-white">CORE</h1>
          </div>
          <span class="text-[11px] font-mono text-orange-400 font-bold">WORSE_QUERY CHAIN</span>
        </header>

        <p class="text-xs text-zinc-400 leading-relaxed">
          One file per slot. The engine backs up the original, writes the payload atomically and re-reads the digest before it reports success.
        </p>

        <!-- ACCESS Card -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-[10px] font-mono text-zinc-500">ACCESS</span>
            <span class="px-2.5 py-0.5 rounded-full bg-crimson-500/15 border border-crimson-500/40 text-crimson-400 text-[10px] font-mono font-bold">• OPEN</span>
          </div>
          <div class="flex items-center justify-between gap-2">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-2xl bg-crimson-500/15 text-crimson-400 flex items-center justify-center">🔓</div>
              <div>
                <div class="text-sm font-bold text-white">App Group sandbox grant</div>
                <div class="text-[11px] font-mono text-zinc-500">__OS_BUILD_LABEL__</div>
              </div>
            </div>
            <button onclick="appendCoreLog('access: App Group sandbox grant verified (OPEN)')" class="px-3.5 py-2 rounded-xl bg-crimson-500 hover:bg-crimson-400 text-white font-mono font-bold text-xs transition cursor-pointer">
              RUN
            </button>
          </div>
        </div>

        <!-- TARGET Card -->
        <div class="glass-card rounded-3xl p-4 space-y-2.5">
          <div class="flex items-center justify-between">
            <span class="text-[10px] font-mono text-zinc-500">TARGET</span>
            <span class="px-2.5 py-0.5 rounded-full bg-crimson-500/15 border border-crimson-500/40 text-crimson-400 text-[10px] font-mono font-bold">• FOUND</span>
          </div>
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-2xl bg-crimson-500/15 text-crimson-400 flex items-center justify-center">⌖</div>
            <div>
              <div class="text-sm font-bold text-white">Free Fire</div>
              <div class="text-[11px] font-mono text-zinc-400">com.dts.freefireth</div>
            </div>
          </div>
          <div class="p-2.5 rounded-xl bg-obsidian-950/90 border border-white/[0.05] text-[10px] font-mono text-zinc-400 break-all">
            /private/var/mobile/Containers/Data/Application/4244BEEC-F61C-4AE8-8BD1-0CD2E258AE6B
          </div>
        </div>

        <!-- LOADOUT Section -->
        <div class="space-y-2.5">
          <div class="flex items-center justify-between">
            <span class="text-xs font-black tracking-wider text-white">LOADOUT</span>
            <span id="core-live-count" class="text-[11px] font-mono text-zinc-400">0/2 LIVE</span>
          </div>

          <div class="glass-card rounded-2xl p-3.5 flex items-center justify-between">
            <div class="flex items-center gap-3">
              <div class="w-9 h-9 rounded-xl bg-crimson-500/15 text-crimson-400 flex items-center justify-center">🧍</div>
              <div>
                <div class="text-[9px] font-mono text-zinc-500">BODY</div>
                <div id="core-body-name" class="text-xs font-bold text-white">PECHO · NORMAL</div>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <span id="core-body-badge" class="px-2.5 py-1 rounded-lg bg-crimson-500/15 text-[10px] font-mono text-crimson-400">• ARMED</span>
              <span class="w-7 h-7 rounded-lg bg-crimson-500 text-white flex items-center justify-center text-xs font-bold">↗</span>
            </div>
          </div>

          <div class="glass-card rounded-2xl p-3.5 flex items-center justify-between">
            <div class="flex items-center gap-3">
              <div class="w-9 h-9 rounded-xl bg-white/10 text-white flex items-center justify-center">⌖</div>
              <div>
                <div class="text-[9px] font-mono text-zinc-500">WEAPON</div>
                <div id="core-weapon-name" class="text-xs font-bold text-white">HOLOGRAMA ARMAS</div>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <span id="core-weapon-badge" class="px-2.5 py-1 rounded-lg bg-white/10 text-[10px] font-mono text-white">• READY</span>
              <span class="w-7 h-7 rounded-lg bg-white text-black flex items-center justify-center text-xs font-bold">↗</span>
            </div>
          </div>

          <div class="flex gap-2">
            <button onclick="triggerCoreLoadoutInject()" class="flex-1 py-3.5 px-4 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 hover:from-crimson-500 hover:to-crimson-400 text-white glow-red flex items-center justify-between transition cursor-pointer">
              <div class="flex items-center gap-2.5">
                <span>⚡</span>
                <div class="text-left">
                  <div class="text-xs font-black tracking-wider">INJECT LOADOUT</div>
                  <div class="text-[10px] font-mono opacity-85">2 slot → Free Fire</div>
                </div>
              </div>
              <span>↗</span>
            </button>
            <button onclick="triggerStageRestore()" class="w-14 rounded-2xl glass-card flex items-center justify-center text-zinc-300 cursor-pointer">↩</button>
          </div>
        </div>

        <!-- CONSOLE Logs -->
        <div class="space-y-2">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
              <span class="text-xs font-black tracking-wider text-white">CONSOLE</span>
              <button onclick="runCoreDiagnose()" class="px-2 py-0.5 rounded-md bg-white/10 border border-white/25 text-[10px] font-mono text-white cursor-pointer">DIAGNOSE</button>
            </div>
            <span id="console-lines-count" class="text-[10px] font-mono text-zinc-500">16 LINES</span>
          </div>
          <div id="core-console-box" class="glass-card rounded-2xl p-3.5 h-44 overflow-y-auto font-mono text-[10px] space-y-1 text-zinc-300">
            <!-- Logs inyectados por JS -->
          </div>
        </div>

        <!-- JOURNAL -->
        <div class="space-y-2">
          <div class="flex items-center justify-between">
            <span class="text-xs font-black tracking-wider text-white">JOURNAL</span>
            <span id="journal-records-count" class="text-[10px] font-mono text-zinc-500">0 RECORDS</span>
          </div>
          <div class="glass-card rounded-2xl p-4 flex items-center gap-3 text-xs text-zinc-400">
            <span>🕒</span>
            <span>Every write lands here with its backup path, so a restore is one tap.</span>
          </div>
        </div>
      </main>

    </div>

    <!-- =====================================================================
         BARRA DE NAVEGACIÓN INFERIOR FLOTANTE (4 PESTAÑAS)
         ===================================================================== -->
    <nav id="bottom-nav" class="hidden fixed bottom-3 left-1/2 -translate-x-1/2 w-[calc(100%-28px)] max-w-[412px] z-30 bg-obsidian-900/95 backdrop-blur-xl border border-white/10 rounded-3xl p-1.5 shadow-2xl flex items-center justify-between">
      <button onclick="switchTab('stage')" id="nav-stage" class="nav-btn flex-1 py-2.5 px-3 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 text-white font-extrabold text-[11px] tracking-wider flex items-center justify-center gap-2 glow-red-soft transition cursor-pointer">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
          <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
        </svg>
        <span class="nav-label">STAGE</span>
      </button>

      <button onclick="switchTab('arsenal')" id="nav-arsenal" class="nav-btn py-2.5 px-3.5 rounded-2xl text-zinc-400 hover:text-white font-extrabold text-[11px] tracking-wider flex items-center justify-center gap-2 transition cursor-pointer">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
          <rect x="3" y="3" width="7" height="7" rx="1.5"/>
          <rect x="14" y="3" width="7" height="7" rx="1.5"/>
          <rect x="14" y="14" width="7" height="7" rx="1.5"/>
          <rect x="3" y="14" width="7" height="7" rx="1.5"/>
        </svg>
        <span class="nav-label hidden">ARSENAL</span>
      </button>

      <button onclick="switchTab('stats')" id="nav-stats" class="nav-btn py-2.5 px-3.5 rounded-2xl text-zinc-400 hover:text-white font-extrabold text-[11px] tracking-wider flex items-center justify-center gap-2 transition cursor-pointer">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
          <line x1="18" y1="20" x2="18" y2="10"/>
          <line x1="12" y1="20" x2="12" y2="4"/>
          <line x1="6" y1="20" x2="6" y2="14"/>
        </svg>
        <span class="nav-label hidden">STATS</span>
      </button>

      <button onclick="switchTab('core')" id="nav-core" class="nav-btn py-2.5 px-3.5 rounded-2xl text-zinc-400 hover:text-white font-extrabold text-[11px] tracking-wider flex items-center justify-center gap-2 transition cursor-pointer">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
          <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
        </svg>
        <span class="nav-label hidden">CORE</span>
      </button>
    </nav>

    <!-- =====================================================================
         MODAL COMPLETO DE SETTINGS (SYSTEM / SETTINGS)
         ===================================================================== -->
    <div id="settings-modal" class="hidden fixed inset-0 z-40 bg-black/85 backdrop-blur-md flex justify-center overflow-y-auto p-3">
      <div class="w-full max-w-[420px] bg-obsidian-900 border border-white/10 rounded-3xl p-4 my-auto space-y-4 shadow-2xl">
        <!-- Header Modal -->
        <div class="flex items-center justify-between">
          <div>
            <div class="text-[10px] font-mono tracking-widest text-zinc-500">SYSTEM</div>
            <h2 class="text-xl font-black tracking-wider text-white">SETTINGS</h2>
          </div>
          <button onclick="closeSettings()" class="w-10 h-10 rounded-full bg-white/5 hover:bg-white/10 flex items-center justify-center text-zinc-300 cursor-pointer">✕</button>
        </div>

        <!-- 1. LICENCE -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-[10px] font-mono text-zinc-500">LICENCE</span>
            <span class="px-2.5 py-0.5 rounded-full bg-crimson-500/15 border border-crimson-500/40 text-crimson-400 text-[10px] font-mono font-bold">• ACTIVE</span>
          </div>

          <div class="flex items-center justify-between bg-obsidian-950/90 border border-white/[0.06] rounded-2xl px-3.5 py-2.5">
            <div class="flex items-center gap-2.5">
              <span class="text-crimson-400">🔑</span>
              <span id="settings-licence-display" class="text-xs font-mono font-bold text-white">EXT-••••••••-FFB832</span>
            </div>
            <button onclick="toggleShowLicence()" id="btn-show-licence" class="text-[11px] font-mono text-zinc-400 hover:text-white cursor-pointer">show</button>
          </div>

          <div class="grid grid-cols-2 gap-2">
            <button onclick="showToast('Licencia sincronizada · GLOBAL')" class="py-2.5 rounded-xl bg-crimson-500/15 border border-crimson-500/40 text-crimson-400 font-mono font-bold text-xs flex items-center justify-center gap-1.5 cursor-pointer">
              ↻ refresh
            </button>
            <button onclick="lockBackToKeyGate()" class="py-2.5 rounded-xl bg-rose-950/70 border border-rose-500/35 text-rose-400 font-mono font-bold text-xs flex items-center justify-center gap-1.5 cursor-pointer">
              🗑 remove
            </button>
          </div>

          <div class="divide-y divide-white/[0.05] text-[11px] font-mono pt-1">
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">PLAN</span><span class="text-white font-bold">GLOBAL</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">EXPIRES</span><span class="text-white font-bold">2026-12-09</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">DEVICE</span><span class="text-white font-bold">13215FED</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">API</span><span class="text-crimson-400 font-bold">ONLINE</span></div>
          </div>
        </div>

        <!-- 2. SECURITY -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-[10px] font-mono text-zinc-500">SECURITY</span>
            <span class="px-2.5 py-0.5 rounded-full bg-white/10 border border-white/25 text-white text-[10px] font-mono font-bold">• READY</span>
          </div>
          <p class="text-[11px] text-zinc-400 leading-relaxed">
            App Attest proves this build is Apple-signed and bound to this device. The key lives in the Secure Enclave; the server keeps only the public half and a counter.
          </p>
          <div class="grid grid-cols-2 gap-2">
            <button onclick="showToast('✓ App Attest verificado en Secure Enclave')" class="py-2.5 rounded-xl bg-white/10 border border-white/25 text-white font-mono font-bold text-xs cursor-pointer">
              ✓ attest
            </button>
            <button onclick="showToast('Mostrando registros de attestation')" class="py-2.5 rounded-xl glass-subcard text-zinc-300 font-mono font-bold text-xs cursor-pointer">
              ⏱ logs
            </button>
          </div>
        </div>

        <!-- 3. VOICE -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-[10px] font-mono text-zinc-500">VOICE</span>
            <span id="voice-status-badge" class="px-2.5 py-0.5 rounded-full bg-crimson-500/15 text-crimson-400 text-[10px] font-mono font-bold">• ACTIVATED</span>
          </div>
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <div class="w-9 h-9 rounded-xl bg-purple-500/15 text-purple-400 flex items-center justify-center">🔊</div>
              <div>
                <div class="text-xs font-bold text-white">Activated voices</div>
                <div class="text-[10px] font-mono text-zinc-500">patchActivated · patchDeactiv...</div>
              </div>
            </div>
            <button onclick="toggleVoiceSwitch()" id="voice-switch" class="w-12 h-7 rounded-full bg-purple-500 p-1 transition flex items-center cursor-pointer">
              <span id="voice-knob" class="w-5 h-5 rounded-full bg-white transition-transform translate-x-5"></span>
            </button>
          </div>
          <p class="text-[10px] text-zinc-500 leading-relaxed">
            Plays the sealed PatchActivated and PatchDeactivated voice lines on commit and restore. On-device only.
          </p>
          <div class="grid grid-cols-2 gap-2">
            <button onclick="playVoiceFeedback('Opción activada')" class="py-2 rounded-xl bg-purple-500/15 border border-purple-500/35 text-purple-300 font-mono text-xs font-bold cursor-pointer">
              ▶ activated
            </button>
            <button onclick="playVoiceFeedback('Opción desactivada')" class="py-2 rounded-xl glass-subcard text-zinc-300 font-mono text-xs font-bold cursor-pointer">
              ▶ deactivated
            </button>
          </div>
        </div>

        <!-- 4. FEED (9 ON DISK) -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-[10px] font-mono text-zinc-500">FEED</span>
            <span class="px-2.5 py-0.5 rounded-full bg-white/10 border border-white/25 text-white text-[10px] font-mono font-bold">• 9 ON DISK</span>
          </div>
          <div class="divide-y divide-white/[0.05] text-[11px] font-mono">
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">SIGNED</span><span class="text-white font-bold">9 packages</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">PROGRESS</span><span class="text-white font-bold">9 packages</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">KEY</span><span class="text-zinc-300 font-bold">D30/m+qA8L9Ykf...</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">REMOTE</span><span class="text-crimson-400 font-bold">enabled</span></div>
          </div>
          <div class="grid grid-cols-2 gap-2">
            <button onclick="showToast('9 paquetes verificados en disco')" class="py-2.5 rounded-xl bg-white/10 hover:bg-white/15 text-white font-mono text-xs font-bold cursor-pointer">↻ sync</button>
            <button onclick="showToast('Caché temporal purgada')" class="py-2.5 rounded-xl bg-rose-950/60 border border-rose-500/35 text-rose-400 font-mono text-xs font-bold cursor-pointer">🗑 purge</button>
          </div>
          <div class="space-y-1 text-[10px] font-mono text-zinc-400 bg-obsidian-950/90 p-3 rounded-2xl">
            <div class="flex justify-between"><span>ANTENA-BALAS-MAGICAS</span><span class="text-zinc-500">362B7107D4CC · 47 KB</span></div>
            <div class="flex justify-between"><span>NORMAL-BALAS-MAGICAS</span><span class="text-zinc-500">BF866EE6D66A · 47 KB</span></div>
            <div class="flex justify-between"><span>ANTENA-CUELLO</span><span class="text-zinc-500">7CDA0DD4EC6C · 47 KB</span></div>
            <div class="flex justify-between"><span>NORMAL-CUELLO</span><span class="text-zinc-500">E7A6227BA623 · 47 KB</span></div>
            <div class="flex justify-between"><span>ANTENA-DRAG</span><span class="text-zinc-500">773E2B531437 · 47 KB</span></div>
            <div class="flex justify-between"><span>NORMAL-DRAG</span><span class="text-zinc-500">3DFC899C56C9 · 47 KB</span></div>
            <div class="flex justify-between"><span>ANTENA-PECHO</span><span class="text-zinc-500">F6AD4BDFBBE7 · 47 KB</span></div>
            <div class="flex justify-between"><span>NORMAL-PECHO</span><span class="text-crimson-400">21E47B87B84E · 47 KB</span></div>
            <div class="flex justify-between"><span>HOLOGRAMA-ARMAS</span><span class="text-white">FF3A3951A09C · 1.5 MB</span></div>
          </div>
        </div>

        <!-- 5. REMOTE -->
        <div class="glass-card rounded-3xl p-4 space-y-2">
          <div class="flex items-center justify-between text-[10px] font-mono">
            <span class="text-zinc-500">REMOTE</span>
            <button onclick="showToast('Estado remoto actualizado')" class="text-white font-bold cursor-pointer">refresh</button>
          </div>
          <div class="divide-y divide-white/[0.05] text-[11px] font-mono">
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">MAINTENANCE</span><span class="text-white font-bold">off</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">MIN BUILD</span><span class="text-white font-bold">1.0</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">ATTEST GATE</span><span class="text-white font-bold">optional</span></div>
            <div class="py-1.5 flex justify-between"><span class="text-zinc-500">INJECT DATE</span><span class="text-crimson-400 font-bold">open</span></div>
          </div>
        </div>

        <!-- 6. LOG (23 lines) -->
        <div class="glass-card rounded-3xl p-4 space-y-3">
          <div class="flex items-center justify-between text-[10px] font-mono">
            <span class="text-zinc-500">LOG</span>
            <span class="text-zinc-400">23 lines</span>
          </div>
          <div id="settings-log-box" class="bg-obsidian-950/90 border border-white/[0.05] rounded-2xl p-3 h-36 overflow-y-auto font-mono text-[10px] space-y-1 text-zinc-400">
            <div>17:37:18  core: 9 payloads · 4 normal · 4 antena · 1 visual</div>
            <div>17:37:18  core: 2 slot(s) — BODY, WEAPON</div>
            <div>17:37:18  engine: bookmark link</div>
            <div>17:37:18  access: worse_query · App Group sandbox grant</div>
            <div>17:37:18  access: sandbox open</div>
            <div>17:37:24  probe: com.dts.freefireth — /private/var/mobile/...</div>
            <div>17:37:24  verify: 0/2 slots live</div>
            <div>17:37:24  security: device 13215FED</div>
            <div>17:37:24  session: offline grace</div>
          </div>
          <div class="grid grid-cols-2 gap-2">
            <button onclick="showToast('Logs subidos al relay')" class="py-2.5 rounded-xl bg-white/10 border border-white/25 text-white font-mono text-xs font-bold cursor-pointer">↑ upload</button>
            <button onclick="document.getElementById('settings-log-box').innerHTML=''; showToast('Logs limpiados')" class="py-2.5 rounded-xl glass-subcard text-zinc-300 font-mono text-xs font-bold cursor-pointer">🗑 clear</button>
          </div>
        </div>
      </div>
    </div>

    <!-- TOAST FLOTANTE DE NOTIFICACIONES (ESTILO VIDEO) -->
    <div id="toast-banner" class="fixed top-4 left-1/2 -translate-x-1/2 z-50 pointer-events-none opacity-0 -translate-y-2 transition-all duration-300">
      <div class="px-4 py-2.5 rounded-2xl bg-obsidian-900/95 border border-crimson-500/50 text-white text-xs font-mono font-bold shadow-2xl flex items-center gap-2 glow-red-soft">
        <span id="toast-icon" class="w-4 h-4 rounded-full bg-crimson-500 text-white flex items-center justify-center text-[10px]">✓</span>
        <span id="toast-text">Listo</span>
      </div>
    </div>

  </div>

  <script>
    // =========================================================================
    // AUDIOS PERSONALIZADOS (incrustados en base64, el HTML sigue siendo un solo archivo)
    // =========================================================================
    const SOUNDS = {
      boot: new Audio('data:audio/mpeg;base64,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'),
      on:   new Audio('data:audio/mpeg;base64,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'),
      off:  new Audio('data:audio/mpeg;base64,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eaCYRmxBBqpaPoTFwcgBg+Kq8xQic+tW0KwkuGTx0fHKnGJMQU1FMy4xMDCqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqr/+5LE7oPZhgr4B5kjyxbBXYDzMvmqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq')
    };
    Object.values(SOUNDS).forEach(a => { a.preload = 'auto'; });

    function playSound(name) {
      const a = SOUNDS[name];
      if (!a) return Promise.resolve();
      Object.values(SOUNDS).forEach(o => { if (o !== a) { o.pause(); } });
      a.currentTime = 0;
      const p = a.play();
      return p && p.catch ? p : Promise.resolve();
    }

    // Sonido de arranque: suena al completarse la barra de Apple.
    // Si el navegador bloquea el autoplay, se reproduce en el primer toque/clic.
    function playBootSound() {
      playSound('boot').catch(() => {
        const unlock = () => {
          ['pointerdown', 'keydown', 'touchstart'].forEach(ev => window.removeEventListener(ev, unlock));
          playSound('boot').catch(() => {});
        };
        ['pointerdown', 'keydown', 'touchstart'].forEach(ev => window.addEventListener(ev, unlock, { once: true }));
      });
    }

    // =========================================================================
    // 0. SECUENCIA DE ARRANQUE APPLE BOOT SCREEN -> KEY GATE
    // =========================================================================
    function startAppleBootSequence() {
      const bar = document.getElementById('apple-boot-bar');
      const bootScreen = document.getElementById('apple-boot-screen');
      const keyGate = document.getElementById('key-gate-screen');

      let progress = 0;
      const interval = setInterval(() => {
        progress += Math.random() * 9 + 4;
        if (progress >= 100) {
          progress = 100;
          bar.style.width = '100%';
          clearInterval(interval);
          playBootSound();
          setTimeout(() => {
            bootScreen.classList.add('boot-fade-out');
            setTimeout(() => {
              bootScreen.classList.add('hidden');
              keyGate.classList.remove('hidden');
            }, 420);
          }, 320);
        } else {
          bar.style.width = progress + '%';
        }
      }, 95);
    }

    // =========================================================================
    // 1. KEY GATE LOGIC — la key SIEMPRE se valida contra el bot de Telegram
    // a traves del puente nativo (Swift llama a KeyVerifier/KeyGateStore, que
    // habla con /api/app/verify). Este archivo nunca decide si una key es
    // valida; solo pide la verificacion y pinta la respuesta.
    // =========================================================================
    let currentActiveKey = 'EXT-••••••••-FFB832';
    let showFullKey = false;
    let keyCheckInFlight = false;

    function setKeyChecking(isChecking) {
      keyCheckInFlight = isChecking;
      const btn = document.getElementById('key-unlock-btn');
      if (!btn) return;
      btn.disabled = isChecking;
      btn.classList.toggle('opacity-60', isChecking);
      btn.querySelector('[data-btn-label]').textContent = isChecking ? 'VERIFICANDO…' : 'DESBLOQUEAR PANEL';
    }

    function validateKeyInput() {
      if (keyCheckInFlight) return;
      const raw = (document.getElementById('key-input').value || '').trim().toUpperCase();
      const feedback = document.getElementById('key-feedback');

      if (!raw) {
        feedback.textContent = '⚠ Ingresa una key para continuar.';
        feedback.className = 'text-xs font-mono px-3 py-2 rounded-xl border border-amber-500/40 bg-amber-500/10 text-amber-300 block';
        return;
      }

      feedback.classList.add('hidden');
      setKeyChecking(true);

      if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.keyGate) {
        window.webkit.messageHandlers.keyGate.postMessage({ action: 'verify', key: raw });
      } else {
        // Sin puente nativo (p.ej. previsualizando el HTML suelto en un navegador)
        // no hay forma de hablar con el bot real: se avisa en vez de fingir un OK.
        setKeyChecking(false);
        feedback.textContent = '✕ Puente nativo no disponible; no se puede verificar.';
        feedback.className = 'text-xs font-mono px-3 py-2 rounded-xl border border-rose-500/50 bg-rose-500/15 text-rose-300 block';
      }
    }

    // Llamado desde Swift (KeyGateStore) con el resultado real del bot.
    window.onKeyResult = function(ok, message, maskedKey) {
      setKeyChecking(false);
      const feedback = document.getElementById('key-feedback');
      if (ok) {
        if (maskedKey) currentActiveKey = maskedKey;
        updateLicenceDisplay();
        feedback.textContent = '✓ Key verificada por el servidor.';
        feedback.className = 'text-xs font-mono px-3 py-2 rounded-xl border border-crimson-500/50 bg-crimson-500/15 text-crimson-300 block';
        // La transicion a la pantalla "versiones soportadas" la maneja la app
        // nativa en cuanto detecta el desbloqueo; aqui no mostramos main-panel.
      } else {
        feedback.textContent = '✕ ' + (message || 'Key invalida.');
        feedback.className = 'text-xs font-mono px-3 py-2 rounded-xl border border-rose-500/50 bg-rose-500/15 text-rose-300 block';
      }
    };

    // Revela el panel principal (pestañas + nav inferior) por encima de la
    // interfaz original de la app. No vuelve a tocar la key gate.
    window.unlockMainInterface = function(maskedKey) {
      if (maskedKey) { currentActiveKey = maskedKey; updateLicenceDisplay(); }
      document.getElementById('apple-boot-screen').classList.add('hidden');
      document.getElementById('key-gate-screen').classList.add('hidden');
      document.getElementById('main-panel').classList.remove('hidden');
      document.getElementById('bottom-nav').classList.remove('hidden');
      resizeCharacterCanvas();
    };

    // Boton "remove" de ajustes: pide a Swift que borre la key guardada
    // (KeyGateStore.reset) y vuelva a mostrar la key gate real.
    function lockBackToKeyGate() {
      closeSettings();
      if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.keyGate) {
        window.webkit.messageHandlers.keyGate.postMessage({ action: 'logout' });
      }
    }

    // =========================================================================
    // 2. DATOS DEL PANEL (PAYLOADS, PARCHES, 35 ARMAS Y LOGS)
    // =========================================================================
    const PAYLOADS = [
      { id: 'balas-magicas', chip: 'BALAS MAGICAS...', title: 'BALAS MAGICAS', slot: 'BODY', size: '46 KB', digest: 'BF866EE6', injected: false },
      { id: 'cuello-antena', chip: 'CUELLO - ANTE...', title: 'CUELLO · ANTENA', slot: 'BODY', size: '47 KB', digest: '7CDA0DD4', injected: false },
      { id: 'cuello-normal', chip: 'CUELLO - NORM...', title: 'CUELLO · NORMAL', slot: 'BODY', size: '47 KB', digest: 'E7A6227B', injected: false },
      { id: 'drag-antena', chip: 'DRAG - ANTENA', title: 'DRAG · ANTENA', slot: 'BODY', size: '47 KB', digest: '773E2B53', injected: false },
      { id: 'drag-normal', chip: 'DRAG - NORMAL', title: 'DRAG · NORMAL', slot: 'BODY', size: '47 KB', digest: '3DFC899C', injected: false },
      { id: 'pecho-antena', chip: 'PECHO - ANTENA', title: 'PECHO · ANTENA', slot: 'BODY', size: '46 KB', digest: 'E776A11A', injected: false },
      { id: 'pecho-normal', chip: 'PECHO - NORMAL', title: 'PECHO · NORMAL', slot: 'BODY', size: '46 KB', digest: '501CFB64', injected: false },
      { id: 'holograma-armas', chip: 'HOLOGRAMA A...', title: 'HOLOGRAMA ARMAS', slot: 'WEAPON', size: '1.5 MB', digest: 'FF3A3951', injected: false },
    ];

    let activeSlot = 'BODY';
    let hologramOn = false;   // false = AK-47 blanco · true = AK-47 rojo (holograma)
    let selectedBodyPayload = PAYLOADS[6];   // PECHO - NORMAL
    let selectedWeaponPayload = PAYLOADS[7]; // HOLOGRAMA ARMAS
    let currentArsenalCat = 'NORMAL';

    const ARSENAL_LIBRARY = {
      VISUALES: [
        { key: 'holograma', name: 'HOLOGRAMA ARMAS', type: 'VISUAL', size: '1.5 MB', active: true, injected: false, color: 'text-white', icon: '⌖' }
      ],
      NORMAL: [
        { key: 'balas', name: 'BALAS MAGICAS', type: 'NORMAL', size: '46 KB', active: false, injected: false, color: 'text-purple-400', icon: '✦' },
        { key: 'cuello', name: 'CUELLO', type: 'NORMAL', size: '46 KB', active: false, injected: false, color: 'text-white', icon: '⌖' },
        { key: 'drag', name: 'DRAG', type: 'NORMAL', size: '46 KB', active: false, injected: false, color: 'text-orange-400', icon: '↑' },
        { key: 'pecho', name: 'PECHO', type: 'NORMAL', size: '46 KB', active: true, injected: false, color: 'text-crimson-400', icon: '🛡' },
      ],
      ANTENA: [
        { key: 'balas-a', name: 'BALAS MAGICAS', type: 'ANTENA', size: '47 KB', active: false, injected: false, color: 'text-purple-400', icon: '✦' },
        { key: 'cuello-a', name: 'CUELLO', type: 'ANTENA', size: '47 KB', active: false, injected: false, color: 'text-white', icon: '⌖' },
        { key: 'drag-a', name: 'DRAG', type: 'ANTENA', size: '47 KB', active: false, injected: false, color: 'text-orange-400', icon: '↑' },
        { key: 'pecho-a', name: 'PECHO', type: 'ANTENA', size: '47 KB', active: true, injected: false, color: 'text-crimson-400', icon: '🛡' },
      ]
    };

    const WEAPONS_35 = [
      {
        category: 'FUSIL DE ASALTO',
        items: [
          { name: 'M4A1', s1: 56, s2: 57, s3: 65 },
          { name: 'AK47', s1: 68, s2: 57, s3: 65 },
          { name: 'SCAR', s1: 55, s2: 56, s3: 70 },
          { name: 'AUG', s1: 49, s2: 60, s3: 62 },
          { name: 'FAMAS', s1: 54, s2: 55, s3: 68 },
          { name: 'XM8', s1: 52, s2: 55, s3: 58 },
          { name: 'AN94', s1: 55, s2: 48, s3: 66 },
          { name: 'PARAFAL', s1: 60, s2: 55, s3: 68 },
          { name: 'GROZA', s1: 55, s2: 63, s3: 55 },
        ]
      },
      {
        category: 'FUSIL DE TIRADOR',
        items: [
          { name: 'M14', s1: 66, s2: 39, s3: 85 },
          { name: 'SKS', s1: 65, s2: 34, s3: 82 },
          { name: 'WOODPECKER', s1: 72, s2: 40, s3: 78 },
          { name: 'SVD', s1: 80, s2: 45, s3: 80 },
        ]
      },
      {
        category: 'SUBFUSIL',
        items: [
          { name: 'MP40', s1: 46, s2: 83, s3: 25 },
          { name: 'UMP', s1: 48, s2: 75, s3: 48 },
          { name: 'MP5', s1: 45, s2: 79, s3: 38 },
          { name: 'VECTOR', s1: 40, s2: 92, s3: 20 },
          { name: 'P90', s1: 46, s2: 80, s3: 42 },
          { name: 'THOMPSON', s1: 50, s2: 71, s3: 45 },
          { name: 'MAC10', s1: 46, s2: 80, s3: 28 },
        ]
      },
      {
        category: 'ESCOPETA',
        items: [
          { name: 'M1014', s1: 94, s2: 46, s3: 20 },
          { name: 'M1887', s1: 100, s2: 52, s3: 22 },
          { name: 'SPAS12', s1: 96, s2: 43, s3: 24 },
        ]
      },
      {
        category: 'RIFLE DE FRANCOTIRADOR',
        items: [
          { name: 'KAR98K', s1: 90, s2: 26, s3: 90 },
          { name: 'AWM', s1: 100, s2: 24, s3: 95 },
          { name: 'M82B', s1: 240, s2: 20, s3: 98 },
        ]
      },
      {
        category: 'AMETRALLADORA',
        items: [
          { name: 'M60', s1: 55, s2: 48, s3: 70 },
          { name: 'M249', s1: 50, s2: 50, s3: 65 },
        ]
      },
      {
        category: 'PISTOLA',
        items: [
          { name: 'DEAGLE', s1: 78, s2: 22, s3: 55 },
          { name: 'USP', s1: 48, s2: 26, s3: 45 },
          { name: 'G18', s1: 34, s2: 60, s3: 35 },
        ]
      },
      {
        category: 'LANZADOR',
        items: [
          { name: 'MGL140', s1: 150, s2: 30, s3: 40 },
          { name: 'RPG7', s1: 300, s2: 15, s3: 60 },
          { name: 'FLAMETHROWER', s1: 30, s2: 90, s3: 15 },
          { name: 'PLASMA', s1: 50, s2: 55, s3: 45 },
        ]
      }
    ];

    const CONSOLE_LOGS = [
      '17:37:18  core: 9 payloads · 4 normal · 4 antena · 1 visual',
      '17:37:18  core: 2 slot(s) — BODY, WEAPON',
      '17:37:18  engine: bookmark link',
      '17:37:18  access: worse_query · App Group sandbox grant',
      '17:37:18  access: sandbox open',
      '17:37:24  probe: com.dts.freefireth — /private/var/mobile/Containers/Data/Application/4244BEEC',
      '17:37:24  verify: 0/2 slots live',
      '17:37:24  container: LaunchServices 27.2c · 1140 container(s)',
      '17:37:26  target: /private/var/mobile/Containers/Data/Application/4244BEEC',
      '17:37:26  verify: 0/2 slots live',
      '17:38:09  inject: HOLOGRAMA ARMAS → WEAPON',
      '17:38:09  ok: HOLOGRAMA ARMAS wrote 1 file(s)',
      '17:38:16  restore: HOLOGRAMA ARMAS @ 17:38:16',
      '17:38:16  ok: original files back in place'
    ];

    // =========================================================================
    // 3. NAVEGACIÓN INFERIOR CON COLORES EXACTOS POR PESTAÑA
    // =========================================================================
    function switchTab(tabId) {
      document.querySelectorAll('.tab-view').forEach(el => el.classList.add('hidden'));
      document.getElementById(`tab-${tabId}`).classList.remove('hidden');

      document.querySelectorAll('.nav-btn').forEach(btn => {
        btn.className = 'nav-btn py-2.5 px-3.5 rounded-2xl text-zinc-400 hover:text-white font-extrabold text-[11px] tracking-wider flex items-center justify-center gap-2 transition cursor-pointer';
        const lbl = btn.querySelector('.nav-label');
        if (lbl) lbl.classList.add('hidden');
      });

      const activeStyles = {
        stage: 'bg-gradient-to-r from-crimson-600 to-crimson-500 text-white glow-red-soft',
        arsenal: 'bg-white text-black glow-white-soft',
        stats: 'bg-gradient-to-r from-violet-600 to-purple-500 text-white glow-purple-soft',
        core: 'bg-gradient-to-r from-orange-600 to-amber-500 text-white glow-orange-soft'
      };

      const activeBtn = document.getElementById(`nav-${tabId}`);
      activeBtn.className = `nav-btn flex-1 py-2.5 px-3 rounded-2xl ${activeStyles[tabId]} font-extrabold text-[11px] tracking-wider flex items-center justify-center gap-2 transition cursor-pointer`;
      const activeLbl = activeBtn.querySelector('.nav-label');
      if (activeLbl) activeLbl.classList.remove('hidden');

      if (tabId === 'stage') resizeCharacterCanvas();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // =========================================================================
    // 4. LÓGICA DE STAGE (ROJO PARA BODY, BLANCO PARA WEAPON)
    // =========================================================================
    function selectStageSlot(slot) {
      activeSlot = slot;
      const isBody = slot === 'BODY';
      const current = isBody ? selectedBodyPayload : selectedWeaponPayload;

      const floatBody = document.getElementById('float-btn-body');
      const floatWeapon = document.getElementById('float-btn-weapon');
      const cardBody = document.getElementById('card-slot-body');
      const cardWeapon = document.getElementById('card-slot-weapon');
      const injectBtn = document.getElementById('btn-stage-inject');
      const armedBadge = document.getElementById('armed-badge');

      if (isBody) {
        floatBody.className = 'w-[144px] p-2.5 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 text-white border border-crimson-400/50 glow-red flex items-center gap-2.5 text-left transition-all cursor-pointer';
        floatWeapon.className = 'w-[144px] p-2.5 rounded-2xl glass-card hover:border-white/30 text-zinc-200 flex items-center gap-2.5 text-left transition-all cursor-pointer';

        cardBody.className = 'p-3 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 text-white border border-crimson-400/50 glow-red-soft flex items-center justify-between text-left transition cursor-pointer';
        cardWeapon.className = 'p-3 rounded-2xl bg-obsidian-900/90 border border-white/10 text-zinc-300 flex items-center justify-between text-left transition cursor-pointer';

        injectBtn.className = 'flex-1 py-3.5 px-4 rounded-2xl bg-gradient-to-r from-crimson-600 to-crimson-500 hover:from-crimson-500 hover:to-crimson-400 active:scale-[0.99] text-white glow-red flex items-center justify-between transition cursor-pointer';
        armedBadge.className = 'px-3 py-1.5 rounded-xl bg-crimson-500/15 border border-crimson-500/40 text-crimson-400 text-[11px] font-mono font-bold tracking-wider';
        document.getElementById('payload-slot').className = 'text-xs font-mono font-bold text-crimson-400 mt-0.5';
        document.getElementById('stage-aura').className = 'absolute left-1/3 top-1/2 -translate-x-1/2 -translate-y-1/2 w-44 h-44 rounded-full bg-crimson-500/20 blur-3xl transition-colors duration-500';
      } else {
        floatWeapon.className = 'w-[144px] p-2.5 rounded-2xl bg-white text-black border border-white glow-white flex items-center gap-2.5 text-left transition-all cursor-pointer';
        floatBody.className = 'w-[144px] p-2.5 rounded-2xl glass-card hover:border-crimson-500/40 text-zinc-200 flex items-center gap-2.5 text-left transition-all cursor-pointer';

        cardWeapon.className = 'p-3 rounded-2xl bg-white text-black border border-white glow-white-soft flex items-center justify-between text-left transition cursor-pointer';
        cardBody.className = 'p-3 rounded-2xl bg-obsidian-900/90 border border-white/10 text-zinc-300 flex items-center justify-between text-left transition cursor-pointer';

        injectBtn.className = 'flex-1 py-3.5 px-4 rounded-2xl bg-white hover:bg-zinc-100 active:scale-[0.99] text-black glow-white flex items-center justify-between transition cursor-pointer';
        armedBadge.className = 'px-3 py-1.5 rounded-xl bg-white/15 border border-white/40 text-white text-[11px] font-mono font-bold tracking-wider';
        document.getElementById('payload-slot').className = 'text-xs font-mono font-bold text-white mt-0.5';
        document.getElementById('stage-aura').className = 'absolute left-1/3 top-1/2 -translate-x-1/2 -translate-y-1/2 w-44 h-44 rounded-full bg-white/15 blur-3xl transition-colors duration-500';
      }

      document.getElementById('active-payload-title').textContent = current.title;
      document.getElementById('payload-size').textContent = current.size;
      document.getElementById('payload-digest').textContent = current.digest;
      document.getElementById('payload-slot').textContent = current.slot;
      document.getElementById('inject-target-sub').textContent = `${slot} → Free Fire`;

      if (current.injected) {
        armedBadge.textContent = '• LIVE';
        document.getElementById('inject-btn-label').textContent = 'RE-INJECT';
      } else {
        armedBadge.textContent = '• ARMED';
        document.getElementById('inject-btn-label').textContent = 'INJECT';
      }

      renderPayloadChips();
    }

    function renderPayloadChips() {
      const container = document.getElementById('payload-chips-container');
      const filtered = PAYLOADS.filter(p => p.slot === activeSlot);
      const current = activeSlot === 'BODY' ? selectedBodyPayload : selectedWeaponPayload;

      container.innerHTML = filtered.map(p => {
        const isSelected = p.id === current.id;
        const activeStyle = activeSlot === 'BODY'
          ? 'bg-crimson-500 text-white border-crimson-400 glow-red-soft'
          : 'bg-white text-black border-white glow-white-soft';
        const idleStyle = 'bg-obsidian-900/90 text-zinc-300 border-white/10 hover:border-white/25';

        return `
          <button
            onclick="choosePayload('${p.id}')"
            class="shrink-0 px-3.5 py-2.5 rounded-xl border text-[11px] font-mono font-bold tracking-wide flex items-center gap-2 transition cursor-pointer ${isSelected ? activeStyle : idleStyle}"
          >
            <span>${p.slot === 'BODY' ? '🧍' : '⌖'}</span>
            <span>${p.chip}</span>
          </button>
        `;
      }).join('');
    }

    function choosePayload(id) {
      const found = PAYLOADS.find(p => p.id === id);
      if (!found) return;
      if (found.id === 'holograma-armas') hologramOn = !hologramOn;
      if (found.slot === 'BODY') {
        selectedBodyPayload = found;
        document.getElementById('core-body-name').textContent = found.title;
        document.getElementById('float-sub-body').textContent = found.title.includes('ANTENA') ? 'ANTENA FIX' : 'NORMAL';
      } else {
        selectedWeaponPayload = found;
        document.getElementById('core-weapon-name').textContent = found.title;
      }
      selectStageSlot(found.slot);
      showToast(found.id === 'holograma-armas' ? (hologramOn ? '✓ Holograma activado' : 'Holograma desactivado') : `✓ ${found.title} armed`);
    }

    function triggerStageInject() {
      const current = activeSlot === 'BODY' ? selectedBodyPayload : selectedWeaponPayload;
      current.injected = true;
      if (current.id === 'holograma-armas') hologramOn = true;
      selectStageSlot(activeSlot);

      if (activeSlot === 'BODY') {
        document.getElementById('slot-status-body').textContent = 'LIVE';
      } else {
        document.getElementById('slot-status-weapon').textContent = 'LIVE';
      }

      const liveTotal = (selectedBodyPayload.injected ? 1 : 0) + (selectedWeaponPayload.injected ? 1 : 0);
      document.getElementById('core-live-count').textContent = `${liveTotal}/2 LIVE`;
      appendCoreLog(`inject: ${current.title} → ${current.slot}`);
      appendCoreLog(`ok: ${current.title} wrote 1 file(s)`);
      showToast(`✓ ${current.title} injected`);
      playVoiceFeedback('Opción activada');
    }

    function triggerStageRestore() {
      const current = activeSlot === 'BODY' ? selectedBodyPayload : selectedWeaponPayload;
      if (current.id === 'holograma-armas') hologramOn = false;
      if (!current.injected) {
        showToast('⚠ Nothing to restore');
        return;
      }
      current.injected = false;
      selectStageSlot(activeSlot);

      if (activeSlot === 'BODY') {
        document.getElementById('slot-status-body').textContent = 'READY';
      } else {
        document.getElementById('slot-status-weapon').textContent = 'READY';
      }

      const liveTotal = (selectedBodyPayload.injected ? 1 : 0) + (selectedWeaponPayload.injected ? 1 : 0);
      document.getElementById('core-live-count').textContent = `${liveTotal}/2 LIVE`;
      appendCoreLog(`restore: ${current.title} → original files back in place`);
      showToast(`✓ Restored ${current.title}`);
      playVoiceFeedback('Opción desactivada');
    }

    // =========================================================================
    // 5. VISOR 3D INTERACTIVO EN CANVAS (motor 3D propio, sin librerías)
    //    - Arrastra a izquierda/derecha para girar el avatar.
    //    - El marcador (cuadro/círculo) se mueve según la opción elegida:
    //      BALAS MAGICAS → círculo grande que cubre todo el avatar
    //      CUELLO        → cuadro entre los hombros
    //      DRAG          → cuadro en la cabeza
    //      PECHO         → cuadro en el pecho
    // =========================================================================
    const canvas = document.getElementById('character-canvas');
    const ctx = canvas.getContext('2d');
    canvas.style.touchAction = 'none';
    let charAngle = 0.45;
    let isDraggingChar = false;
    let lastPointerX = 0;
    let angleVelocity = 0;
    let lastInteraction = -1e9;
    let lastFrameTime = performance.now();

    const VIEW_PITCH = 0.24;   // inclinación de cámara (se ve la plataforma desde arriba)
    const CAM_DIST = 520;      // perspectiva suave

    function resizeCharacterCanvas() {
      const parent = canvas.parentElement;
      if (!parent) return;
      const dpr = window.devicePixelRatio || 1;
      canvas.width = parent.clientWidth * dpr;
      canvas.height = parent.clientHeight * dpr;
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    }

    canvas.addEventListener('pointerdown', (e) => {
      isDraggingChar = true;
      lastPointerX = e.clientX;
      angleVelocity = 0;
      lastInteraction = performance.now();
      try { canvas.setPointerCapture(e.pointerId); } catch (err) {}
    });
    window.addEventListener('pointermove', (e) => {
      if (!isDraggingChar) return;
      const dx = e.clientX - lastPointerX;
      lastPointerX = e.clientX;
      const delta = dx * 0.013;
      charAngle += delta;
      angleVelocity = Math.max(-0.2, Math.min(0.2, delta));
      lastInteraction = performance.now();
    });
    function endCharDrag() {
      if (!isDraggingChar) return;
      isDraggingChar = false;
      lastInteraction = performance.now();
    }
    window.addEventListener('pointerup', endCharDrag);
    window.addEventListener('pointercancel', endCharDrag);

    // ---------- Matemática 3D ----------
    function viewXf(p, a) {
      const c = Math.cos(a), s = Math.sin(a);
      const x = p[0] * c + p[2] * s;
      const z1 = -p[0] * s + p[2] * c;
      const ct = Math.cos(VIEW_PITCH), st = Math.sin(VIEW_PITCH);
      return [x, p[1] * ct - z1 * st, p[1] * st + z1 * ct];
    }
    function projectPt(p, cx, cy) {
      const k = CAM_DIST / (CAM_DIST - p[2]);
      return [cx + p[0] * k, cy - p[1] * k, k];
    }
    const BOX_FACES = [
      { n: [0, 0, 1],  v: [[-1,-1, 1],[ 1,-1, 1],[ 1, 1, 1],[-1, 1, 1]] },
      { n: [0, 0, -1], v: [[ 1,-1,-1],[-1,-1,-1],[-1, 1,-1],[ 1, 1,-1]] },
      { n: [1, 0, 0],  v: [[ 1,-1, 1],[ 1,-1,-1],[ 1, 1,-1],[ 1, 1, 1]] },
      { n: [-1, 0, 0], v: [[-1,-1,-1],[-1,-1, 1],[-1, 1, 1],[-1, 1,-1]] },
      { n: [0, 1, 0],  v: [[-1, 1, 1],[ 1, 1, 1],[ 1, 1,-1],[-1, 1,-1]] },
      { n: [0, -1, 0], v: [[-1,-1,-1],[ 1,-1,-1],[ 1,-1, 1],[-1,-1, 1]] },
    ];
    function boxFaces(c, h, a, cx, cy) {
      return BOX_FACES.map(f => {
        const n = viewXf(f.n, a);
        const p3 = f.v.map(v => viewXf([c[0] + v[0] * h[0], c[1] + v[1] * h[1], c[2] + v[2] * h[2]], a));
        const mid = [0, 0, 0];
        p3.forEach(p => { mid[0] += p[0] / 4; mid[1] += p[1] / 4; mid[2] += p[2] / 4; });
        const facing = n[0] * (0 - mid[0]) + n[1] * (0 - mid[1]) + n[2] * (CAM_DIST - mid[2]);
        return { n, facing, z: mid[2], pts: p3.map(p => projectPt(p, cx, cy)) };
      });
    }
    const LIGHT = (() => { const l = [-0.45, 0.65, 0.62]; const m = Math.hypot(l[0], l[1], l[2]); return l.map(v => v / m); })();
    function shadeColor(rgb, n) {
      const lam = Math.max(0, n[0] * LIGHT[0] + n[1] * LIGHT[1] + n[2] * LIGHT[2]);
      const f = 0.8 + 1.1 * lam;
      return `rgb(${Math.min(255, rgb[0] * f) | 0},${Math.min(255, rgb[1] * f) | 0},${Math.min(255, rgb[2] * f) | 0})`;
    }
    function polyPath(pts) {
      ctx.beginPath();
      pts.forEach((p, i) => (i ? ctx.lineTo(p[0], p[1]) : ctx.moveTo(p[0], p[1])));
      ctx.closePath();
    }

    // ---------- Marcador rojo/blanco ----------
    const MARKER_TARGETS = {
      pecho:  { y: 11, hx: 11, hy: 11, hz: 13, sphere: 0 },
      cuello: { y: 37, hx: 19, hy: 6,  hz: 13, sphere: 0 },
      drag:   { y: 54, hx: 19, hy: 19, hz: 19, sphere: 0 },
      balas:  { y: 0,  hx: 40, hy: 90, hz: 30, sphere: 1 },
    };
    const markerState = Object.assign({}, MARKER_TARGETS.pecho);

    function currentMarkerKey() {
      if (activeSlot !== 'BODY') return 'pecho';
      const id = (selectedBodyPayload && selectedBodyPayload.id) || '';
      if (id.startsWith('balas')) return 'balas';
      if (id.startsWith('cuello')) return 'cuello';
      if (id.startsWith('drag')) return 'drag';
      return 'pecho';
    }


    // ---------- AK-47 3D (perfil extruido, mismo motor que el avatar) ----------
    const gunRect = (x0, y0, x1, y1) => [[x0, y0], [x1, y0], [x1, y1], [x0, y1]];
    const GUN_PARTS = [
      { poly: [[-42, 6], [-80, 2], [-80, -14], [-42, -6]], hz: 5 },        // culata
      { poly: gunRect(-44, -8, 14, 10), hz: 6 },                           // caja del cerrojo
      { poly: gunRect(-44, 10, 10, 13.5), hz: 5 },                         // tapa superior
      { poly: [[-6, -8], [-18, -8], [-26, -32], [-16, -32]], hz: 4.5 },    // empuñadura
      { poly: gunRect(-3, -12, 14, -8), hz: 1.6 },                         // guardamonte
      { poly: [[2, -8], [16, -8], [24, -32], [10, -32]], hz: 5 },          // cargador (1)
      { poly: [[10, -32], [24, -32], [38, -48], [25, -48]], hz: 5 },       // cargador (2)
      { poly: gunRect(14, -4, 48, 7), hz: 5.5 },                           // guardamanos inferior
      { poly: gunRect(14, 7, 46, 12), hz: 4.5 },                           // guardamanos superior
      { poly: gunRect(46, -2, 54, 13), hz: 3.2 },                          // bloque de gas
      { poly: gunRect(48, 2.2, 78, 5.8), hz: 1.8 },                        // cañón
      { poly: gunRect(72, 1, 80, 7), hz: 3 },                              // freno de boca
      { poly: gunRect(56, 5.8, 63, 10), hz: 2.4 },                         // base de la mira
      { poly: gunRect(58.5, 10, 60.5, 18), hz: 1.2 },                      // punto de mira
      { poly: gunRect(0, 13.5, 12, 16.5), hz: 3 },                         // alza trasera
      { poly: gunRect(-8, 4, -2, 7), hz: 1.5, zc: 7.5 },                   // palanca de carga
      { poly: gunRect(-34, -1, -6, 0.8), hz: 0.7, zc: 6.7 },               // selector de fuego
    ];
    GUN_PARTS.forEach(p => {
      let area = 0;
      for (let i = 0; i < p.poly.length; i++) {
        const q = p.poly[i], r = p.poly[(i + 1) % p.poly.length];
        area += q[0] * r[1] - r[0] * q[1];
      }
      if (area < 0) p.poly.reverse();   // orientación antihoraria para calcular normales
      p.zc = p.zc || 0;
      const xs = p.poly.map(v => v[0]), ys = p.poly.map(v => v[1]);
      p.cx = (Math.min(...xs) + Math.max(...xs)) / 2;
      p.cy = (Math.min(...ys) + Math.max(...ys)) / 2;
    });

    function gunPartFaces(part, a, cx, cy, S, offY) {
      const poly = part.poly, n = poly.length, zc = part.zc, hz = part.hz;
      const V = (x, y, z) => viewXf([x * S, y * S + offY, z * S], a);
      const mk = (norm, verts3) => {
        const nn = viewXf(norm, a);
        const mid = [0, 0, 0];
        verts3.forEach(p => { mid[0] += p[0] / verts3.length; mid[1] += p[1] / verts3.length; mid[2] += p[2] / verts3.length; });
        const facing = nn[0] * (0 - mid[0]) + nn[1] * (0 - mid[1]) + nn[2] * (CAM_DIST - mid[2]);
        return { n: nn, facing, z: mid[2], pts: verts3.map(p => projectPt(p, cx, cy)) };
      };
      const faces = [];
      faces.push(mk([0, 0, 1], poly.map(v => V(v[0], v[1], zc + hz))));
      faces.push(mk([0, 0, -1], poly.slice().reverse().map(v => V(v[0], v[1], zc - hz))));
      for (let i = 0; i < n; i++) {
        const p = poly[i], q = poly[(i + 1) % n];
        const dx = q[0] - p[0], dy = q[1] - p[1], len = Math.hypot(dx, dy) || 1;
        faces.push(mk([dy / len, -dx / len, 0], [V(p[0], p[1], zc + hz), V(q[0], q[1], zc + hz), V(q[0], q[1], zc - hz), V(p[0], p[1], zc - hz)]));
      }
      return faces;
    }

    let weaponMix = 0;   // 0 = avatar · 1 = arma
    let holoMix = 0;     // 0 = blanco · 1 = rojo (holograma)

    function drawGun(a, cx, cy, now) {
      const S = 1.25 * (0.9 + 0.1 * weaponMix);
      const offY = 6 + Math.sin(now / 650) * 3;
      const lerp = (u, v) => u + (v - u) * holoMix;
      const base = [lerp(238, 255), lerp(241, 40), lerp(248, 58)];
      const edge = `rgb(${lerp(141, 255) | 0},${lerp(151, 120) | 0},${lerp(171, 132) | 0})`;
      ctx.save();
      ctx.globalAlpha = weaponMix;
      ctx.lineJoin = 'round';
      if (holoMix > 0.02) {
        ctx.shadowColor = `rgba(255, 42, 60, ${holoMix})`;
        ctx.shadowBlur = 12 * holoMix;
      }
      GUN_PARTS
        .map(p => ({ p, z: viewXf([p.cx * S, p.cy * S + offY, p.zc * S], a)[2] + p.hz * 0.01 }))
        .sort((u, v) => u.z - v.z)
        .forEach(({ p }) => {
          gunPartFaces(p, a, cx, cy, S, offY)
            .filter(f => f.facing > 0)
            .sort((u, v) => u.z - v.z)
            .forEach(f => {
              const lam = Math.max(0, f.n[0] * LIGHT[0] + f.n[1] * LIGHT[1] + f.n[2] * LIGHT[2]);
              const k = 0.8 + 0.3 * lam;
              polyPath(f.pts);
              ctx.fillStyle = `rgb(${Math.min(255, base[0] * k) | 0},${Math.min(255, base[1] * k) | 0},${Math.min(255, base[2] * k) | 0})`;
              ctx.fill();
              ctx.strokeStyle = edge;
              ctx.lineWidth = 1;
              ctx.stroke();
            });
        });
      ctx.restore();
    }

    function draw3DCharacter() {
      const now = performance.now();
      const dt = Math.min(0.05, (now - lastFrameTime) / 1000);
      lastFrameTime = now;
      const w = canvas.clientWidth;
      const h = canvas.clientHeight;

      if (w > 0 && h > 0) {
        // Giro: inercia al soltar + auto-giro suave tras unos segundos sin tocar
        if (isDraggingChar) {
          angleVelocity *= 0.8;
        } else {
          charAngle += angleVelocity * dt * 60;
          angleVelocity *= Math.pow(0.92, dt * 60);
          if (Math.abs(angleVelocity) < 0.002 && now - lastInteraction > 3500) charAngle += 0.48 * dt;
        }
        const a = charAngle;

        // Animación suave del marcador hacia su destino
        const tgt = MARKER_TARGETS[currentMarkerKey()];
        const kk = 1 - Math.exp(-dt * 9);
        ['y', 'hx', 'hy', 'hz', 'sphere'].forEach(k => { markerState[k] += (tgt[k] - markerState[k]) * kk; });

        // Transición avatar ⇄ arma y color del holograma
        weaponMix += ((activeSlot === 'WEAPON' ? 1 : 0) - weaponMix) * kk;
        holoMix += ((hologramOn ? 1 : 0) - holoMix) * kk;
        const avA = 1 - weaponMix;
        const isBody = activeSlot === 'BODY';
        const redAcc = isBody || hologramOn;
        const accent = redAcc ? '#ff2a3c' : '#ffffff';
        const accentRgb = redAcc ? '255,42,60' : '255,255,255';
        const cx = w * 0.34;
        const cy = h * 0.54;

        ctx.clearRect(0, 0, w, h);
        ctx.save();
        ctx.lineJoin = 'round';

        // Plataforma con anillo (rota con las marcas)
        const pc = projectPt(viewXf([0, -84, 0], a), cx, cy);
        const rx = 54 * pc[2], ry = 54 * Math.sin(VIEW_PITCH) * pc[2];
        ctx.beginPath();
        ctx.ellipse(pc[0], pc[1], rx, ry, 0, 0, Math.PI * 2);
        ctx.fillStyle = redAcc ? 'rgba(255, 42, 60, 0.16)' : 'rgba(255, 255, 255, 0.12)';
        ctx.fill();
        ctx.strokeStyle = accent;
        ctx.lineWidth = 1.4;
        ctx.stroke();
        for (let i = 0; i < 6; i++) {
          const t = a + i * Math.PI / 3;
          const x1 = Math.cos(t), y1 = Math.sin(t);
          ctx.beginPath();
          ctx.moveTo(pc[0] + x1 * rx * 0.88, pc[1] + y1 * ry * 0.88);
          ctx.lineTo(pc[0] + x1 * rx * 1.06, pc[1] + y1 * ry * 1.06);
          ctx.globalAlpha = 0.45 + 0.4 * Math.max(0, y1);
          ctx.stroke();
        }
        ctx.globalAlpha = 1;

        if (avA > 0.01) {
        ctx.globalAlpha = avA;
        // Cajas del marcador (caras traseras primero, delanteras al final)
        const boxAlpha = Math.max(0, 1 - markerState.sphere * 1.4);
        const mFaces = boxAlpha > 0.02
          ? boxFaces([0, markerState.y, 0], [markerState.hx, markerState.hy, markerState.hz], a, cx, cy)
          : [];
        mFaces.filter(f => f.facing <= 0).sort((p, q) => p.z - q.z).forEach(f => {
          polyPath(f.pts);
          ctx.fillStyle = `rgba(${accentRgb}, ${0.07 * boxAlpha})`;
          ctx.fill();
          ctx.strokeStyle = `rgba(${accentRgb}, ${0.35 * boxAlpha})`;
          ctx.lineWidth = 1;
          ctx.stroke();
        });

        // Partes del cuerpo (ordenadas por profundidad)
        const parts = [];
        const addBox = (c, hh, rgb, stroke) => {
          parts.push({
            z: viewXf(c, a)[2],
            draw: () => {
              boxFaces(c, hh, a, cx, cy).filter(f => f.facing > 0).sort((p, q) => p.z - q.z).forEach(f => {
                polyPath(f.pts);
                ctx.fillStyle = shadeColor(rgb, f.n);
                ctx.fill();
                ctx.strokeStyle = stroke;
                ctx.lineWidth = 1.5;
                ctx.stroke();
              });
            }
          });
        };
        addBox([-10.5, -48, 0], [6.5, 32, 6.5], [19, 23, 34], '#2e3648');   // pierna izq
        addBox([10.5, -48, 0],  [6.5, 32, 6.5], [19, 23, 34], '#2e3648');   // pierna der
        addBox([0, 8, 0],       [18, 26, 10],   [25, 30, 44], '#3b455b');   // torso
        addBox([-24, 8, 0],     [5, 22, 5],     [20, 25, 37], '#334155');   // brazo izq
        addBox([24, 8, 0],      [5, 22, 5],     [20, 25, 37], '#334155');   // brazo der

        // Cabeza (esfera) + orejas tácticas + visor
        parts.push({
          z: viewXf([0, 52, 0], a)[2],
          draw: () => {
            const hc = projectPt(viewXf([0, 52, 0], a), cx, cy);
            const r = 15 * hc[2];
            const g = ctx.createRadialGradient(hc[0] - r * 0.35, hc[1] - r * 0.4, r * 0.1, hc[0], hc[1], r);
            g.addColorStop(0, '#2b3446');
            g.addColorStop(1, '#10141d');
            ctx.beginPath();
            ctx.arc(hc[0], hc[1], r, 0, Math.PI * 2);
            ctx.fillStyle = g;
            ctx.fill();
            ctx.strokeStyle = '#475569';
            ctx.lineWidth = 1.5;
            ctx.stroke();

            [-1, 1].forEach(sd => {
              const pts = [[sd * 9, 64, 0], [sd * 14, 82, 0], [sd * 3, 66, 0]].map(p => projectPt(viewXf(p, a), cx, cy));
              ctx.beginPath();
              ctx.moveTo(pts[0][0], pts[0][1]);
              ctx.lineTo(pts[1][0], pts[1][1]);
              ctx.lineTo(pts[2][0], pts[2][1]);
              ctx.strokeStyle = accent;
              ctx.lineWidth = 2;
              ctx.stroke();
            });

            // Visor: dos barras sobre la superficie frontal de la esfera
            [[-8, -2], [2, 8]].forEach(([x0, x1]) => {
              const corners = [[x0, 55], [x1, 55], [x1, 52], [x0, 52]].map(([x, y]) => {
                const zz = Math.sqrt(Math.max(0, 225 - x * x - (y - 52) * (y - 52)));
                return [x, y, zz];
              });
              const midP = viewXf([(x0 + x1) / 2, 53.5, Math.sqrt(Math.max(0, 225 - ((x0 + x1) / 2) ** 2 - 2.25))], a);
              const nrm = viewXf([(x0 + x1) / 2, 1.5, Math.sqrt(Math.max(0, 225 - ((x0 + x1) / 2) ** 2 - 2.25))], a);
              if (nrm[2] > 1) {
                const pp = corners.map(c3 => projectPt(viewXf(c3, a), cx, cy));
                polyPath(pp);
                ctx.fillStyle = accent;
                ctx.shadowColor = accent;
                ctx.shadowBlur = 10;
                ctx.fill();
                ctx.shadowBlur = 0;
              }
            });
          }
        });

        parts.sort((p, q) => p.z - q.z).forEach(p => p.draw());

        // Caras delanteras del marcador (cuadro)
        mFaces.filter(f => f.facing > 0).sort((p, q) => p.z - q.z).forEach(f => {
          polyPath(f.pts);
          ctx.fillStyle = `rgba(${accentRgb}, ${0.22 * boxAlpha})`;
          ctx.fill();
          ctx.shadowColor = accent;
          ctx.shadowBlur = 10 * boxAlpha;
          ctx.strokeStyle = `rgba(${accentRgb}, ${boxAlpha})`;
          ctx.lineWidth = 1.7;
          ctx.stroke();
          ctx.shadowBlur = 0;
        });

        // Círculo grande (BALAS MAGICAS): cubre todo el avatar
        if (markerState.sphere > 0.02) {
          const mc = projectPt(viewXf([0, markerState.y, 0], a), cx, cy);
          const R = Math.max(4, markerState.sphere * 98);
          const s = markerState.sphere;
          const grad = ctx.createRadialGradient(mc[0], mc[1], R * 0.2, mc[0], mc[1], R);
          grad.addColorStop(0, `rgba(${accentRgb}, ${0.04 * s})`);
          grad.addColorStop(1, `rgba(${accentRgb}, ${0.2 * s})`);
          ctx.beginPath();
          ctx.arc(mc[0], mc[1], R, 0, Math.PI * 2);
          ctx.fillStyle = grad;
          ctx.fill();
          ctx.shadowColor = accent;
          ctx.shadowBlur = 14 * s;
          ctx.strokeStyle = `rgba(${accentRgb}, ${s})`;
          ctx.lineWidth = 2;
          ctx.stroke();
          ctx.shadowBlur = 0;
          ctx.beginPath();
          ctx.arc(mc[0], mc[1], R * 0.92, 0, Math.PI * 2);
          ctx.setLineDash([5, 7]);
          ctx.lineDashOffset = -a * 30;
          ctx.strokeStyle = `rgba(${accentRgb}, ${0.55 * s})`;
          ctx.lineWidth = 1;
          ctx.stroke();
          ctx.setLineDash([]);
        }
        ctx.globalAlpha = 1;
        }
        if (weaponMix > 0.01) drawGun(a, cx, cy, now);
        ctx.restore();
      }
      requestAnimationFrame(draw3DCharacter);
    }

    // =========================================================================
    // 6. ARSENAL (PATCH STUDIO), STATS Y CORE
    // =========================================================================
    // Marcador del avatar de ARSENAL (el avatar SVG queda quieto; solo el cuadro se mueve)
    const ARSENAL_MARKER_TARGETS = {
      pecho:  { x: 48,  y: 56, w: 24,  h: 22,  rx: 0,  fo: 0.2 },
      cuello: { x: 46,  y: 40, w: 28,  h: 12,  rx: 0,  fo: 0.2 },
      drag:   { x: 45,  y: 13, w: 30,  h: 30,  rx: 0,  fo: 0.2 },
      balas:  { x: -38, y: 0,  w: 196, h: 196, rx: 98, fo: 0.13 },
    };
    const arsenalMarkerState = Object.assign({}, ARSENAL_MARKER_TARGETS.pecho);
    let arsenalMarkerLast = performance.now();

    function bodyPartKey() {
      const id = (selectedBodyPayload && selectedBodyPayload.id) || '';
      if (id.startsWith('balas')) return 'balas';
      if (id.startsWith('cuello')) return 'cuello';
      if (id.startsWith('drag')) return 'drag';
      return 'pecho';
    }

    function tickArsenalMarker() {
      const now = performance.now();
      const dt = Math.min(0.05, (now - arsenalMarkerLast) / 1000);
      arsenalMarkerLast = now;
      const el = document.getElementById('arsenal-marker');
      if (el) {
        const tgt = ARSENAL_MARKER_TARGETS[bodyPartKey()];
        const k = 1 - Math.exp(-dt * 9);
        const st = arsenalMarkerState;
        ['x', 'y', 'w', 'h', 'rx', 'fo'].forEach(p => { st[p] += (tgt[p] - st[p]) * k; });
        el.setAttribute('x', st.x.toFixed(2));
        el.setAttribute('y', st.y.toFixed(2));
        el.setAttribute('width', st.w.toFixed(2));
        el.setAttribute('height', st.h.toFixed(2));
        el.setAttribute('rx', st.rx.toFixed(2));
        el.setAttribute('fill-opacity', st.fo.toFixed(3));
      }
      requestAnimationFrame(tickArsenalMarker);
    }

    // Elige la parte del cuerpo (Stage y Arsenal comparten esta selección)
    function setBodyPart(base, antena) {
      const id = base === 'balas' ? 'balas-magicas' : `${base}-${antena ? 'antena' : 'normal'}`;
      const found = PAYLOADS.find(p => p.id === id);
      if (!found) return;
      selectedBodyPayload = found;
      document.getElementById('core-body-name').textContent = found.title;
      document.getElementById('float-sub-body').textContent = found.title.includes('ANTENA') ? 'ANTENA FIX' : 'NORMAL';
      selectStageSlot(activeSlot);
    }

    function armOrbitalPatch(name) {
      const map = { 'DRAG': 'drag', 'CUELLO': 'cuello', 'PECHO': 'pecho', 'BALAS MÁGICAS': 'balas' };
      if (map[name]) setBodyPart(map[name], currentArsenalCat === 'ANTENA');
      showToast(`✓ ${name} armed`);
    }

    function setArsenalCategory(cat) {
      currentArsenalCat = cat;
      ['VISUALES', 'NORMAL', 'ANTENA'].forEach(c => {
        const btn = document.getElementById(`cat-${c}`);
        if (c === cat) {
          btn.className = 'cat-btn p-3 rounded-2xl bg-white/10 border border-white/60 text-left flex items-center justify-between transition cursor-pointer glow-white-soft';
          btn.children[0].className = 'text-[10px] font-bold text-white';
          btn.children[1].className = 'px-1.5 py-0.5 rounded-md bg-white text-black text-[10px] font-mono font-bold';
        } else {
          btn.className = 'cat-btn p-3 rounded-2xl glass-card text-left flex items-center justify-between transition cursor-pointer';
          btn.children[0].className = 'text-[10px] font-bold text-zinc-400';
          btn.children[1].className = 'px-1.5 py-0.5 rounded-md bg-white/5 text-[10px] font-mono text-zinc-400';
        }
      });
      renderArsenalList();
    }

    function renderArsenalList() {
      const container = document.getElementById('arsenal-patch-list');
      const items = ARSENAL_LIBRARY[currentArsenalCat] || [];

      container.innerHTML = items.map((p, idx) => {
        const badgeText = p.injected ? 'LIVE' : (p.active ? 'ARMED' : 'READY');
        const badgeClass = p.injected
          ? 'bg-crimson-500/20 text-crimson-400 border border-crimson-500/40'
          : (p.active ? 'bg-white/15 text-white border border-white/30' : 'text-zinc-500');

        return `
          <div class="glass-card rounded-3xl p-4 space-y-3 transition ${p.active ? 'border-white/35' : ''}">
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-white/5 ${p.color} flex items-center justify-center text-base font-bold">
                  ${p.icon}
                </div>
                <div>
                  <div class="text-xs font-black tracking-wider text-white">${p.name}</div>
                  <div class="text-[10px] font-mono text-zinc-400 mt-0.5">
                    ${p.type} · ${p.size} · <span class="${p.active ? 'text-white font-bold' : ''}">${badgeText}</span>
                  </div>
                </div>
              </div>

              ${currentArsenalCat === 'VISUALES'
                ? `<span class="px-2.5 py-1 rounded-lg text-[10px] font-mono font-bold ${badgeClass}">${badgeText}</span>`
                : `<button onclick="toggleArsenalItem(${idx})" class="w-12 h-7 rounded-full p-1 transition flex items-center cursor-pointer ${p.active ? 'bg-crimson-500 glow-red-soft' : 'bg-zinc-800'}">
                     <span class="w-5 h-5 rounded-full bg-white transition-transform ${p.active ? 'translate-x-5' : 'translate-x-0'}"></span>
                   </button>`
              }
            </div>

            ${p.active ? `
              <div class="grid grid-cols-2 gap-2.5 pt-1">
                <button onclick="injectArsenalItem(${idx})" class="py-3 rounded-2xl bg-white hover:bg-zinc-100 text-black font-black text-xs tracking-widest uppercase transition active:scale-95 cursor-pointer">
                  INJECT
                </button>
                <button onclick="restoreArsenalItem(${idx})" class="py-3 rounded-2xl glass-subcard hover:border-white/25 text-zinc-300 font-bold text-xs tracking-widest uppercase transition active:scale-95 cursor-pointer">
                  RESTORE
                </button>
              </div>
            ` : ''}
          </div>
        `;
      }).join('');
    }

    function toggleArsenalItem(idx) {
      const item = ARSENAL_LIBRARY[currentArsenalCat][idx];
      item.active = !item.active;
      renderArsenalList();
      if (item.active) {
        syncBodyPayloadFromArsenal(item);
        showToast(`✓ ${item.name} armed`);
      }
    }

    // Al armar una opción en Arsenal, el avatar mueve su marcador igual que en el Stage
    function syncBodyPayloadFromArsenal(item) {
      const base = String(item.key || '').replace(/-a$/, '');
      if (['balas', 'cuello', 'drag', 'pecho'].includes(base)) setBodyPart(base, /-a$/.test(item.key));
    }

    function injectArsenalItem(idx) {
      const item = ARSENAL_LIBRARY[currentArsenalCat][idx];
      item.injected = true;
      if (item.key === 'holograma') hologramOn = true;
      renderArsenalList();
      appendCoreLog(`inject: ${item.name} (${item.type}) → OK`);
      showToast(`✓ ${item.name} injected`);
      playVoiceFeedback('Opción activada');
    }

    function restoreArsenalItem(idx) {
      const item = ARSENAL_LIBRARY[currentArsenalCat][idx];
      if (!item.injected) {
        showToast('⚠ Nothing to restore');
        return;
      }
      item.injected = false;
      if (item.key === 'holograma') hologramOn = false;
      renderArsenalList();
      appendCoreLog(`restore: ${item.name} → restored`);
      showToast(`✓ Restored ${item.name}`);
      playVoiceFeedback('Opción desactivada');
    }

    function renderStatsWeapons() {
      const container = document.getElementById('stats-weapons-grid');
      container.innerHTML = WEAPONS_35.map(group => `
        <div class="space-y-2">
          <div class="text-[10px] font-mono text-zinc-500 tracking-wider">${group.category}</div>
          <div class="grid grid-cols-2 gap-2">
            ${group.items.map(w => `
              <div class="p-2.5 rounded-2xl glass-subcard">
                <div class="text-xs font-black text-white">${w.name}</div>
                <div class="flex items-center gap-2.5 mt-1 text-[10px] font-mono text-zinc-400">
                  <span>↓${w.s1}</span>
                  <span>▲${w.s2}</span>
                  <span>⌖${w.s3}</span>
                </div>
              </div>
            `).join('')}
          </div>
        </div>
      `).join('');
    }

    function loadPlayerStats() {
      const val = document.getElementById('ff-uid-input').value.trim() || '817837121';
      document.getElementById('uid-remembered-label').textContent = val;
      document.getElementById('player-uid-sub').textContent = `UID ${val}`;
      showToast(`✓ Perfil UID ${val} actualizado`);
    }

    function resetUidInput() {
      document.getElementById('ff-uid-input').value = '';
      showToast('UID limpiado');
    }

    function copyUidText() {
      const uid = document.getElementById('ff-uid-input').value.trim() || '817837121';
      const temp = document.createElement('input');
      temp.value = uid;
      document.body.appendChild(temp);
      temp.select();
      document.execCommand('copy');
      document.body.removeChild(temp);
      showToast(`✓ UID ${uid} copiado`);
    }

    function renderCoreLogs() {
      const box = document.getElementById('core-console-box');
      box.innerHTML = CONSOLE_LOGS.map(line => {
        const isOk = line.includes('ok:') || line.includes('verify:');
        const isWarn = line.includes('inject:') || line.includes('restore:');
        const color = isOk ? 'text-crimson-400' : (isWarn ? 'text-orange-400' : 'text-zinc-400');
        return `<div class="${color} leading-relaxed">${line}</div>`;
      }).join('');
      document.getElementById('console-lines-count').textContent = `${CONSOLE_LOGS.length} LINES`;
      box.scrollTop = box.scrollHeight;
    }

    function appendCoreLog(msg) {
      const ts = new Date().toTimeString().split(' ')[0];
      CONSOLE_LOGS.push(`${ts}  ${msg}`);
      renderCoreLogs();
    }

    function triggerCoreLoadoutInject() {
      selectedBodyPayload.injected = true;
      selectedWeaponPayload.injected = true;
      if (selectedWeaponPayload.id === 'holograma-armas') hologramOn = true;
      document.getElementById('core-live-count').textContent = '2/2 LIVE';
      document.getElementById('journal-records-count').textContent = '2 RECORDS';
      appendCoreLog(`inject: ${selectedBodyPayload.title} + ${selectedWeaponPayload.title}`);
      appendCoreLog('verify: 2/2 slots live');
      showToast('✓ Loadout completo (2/2) inyectado');
      playVoiceFeedback('Opción activada');
    }

    function runCoreDiagnose() {
      appendCoreLog('diagnose: App Group & entitlements OK (Pepo Banned)');
      showToast('✓ Diagnóstico completado sin errores');
    }

    // =========================================================================
    // 7. SETTINGS MODAL, VOZ SINTETIZADA Y TOASTS
    // =========================================================================
    let voiceEnabled = true;

    function openSettings() {
      document.getElementById('settings-modal').classList.remove('hidden');
    }
    function closeSettings() {
      document.getElementById('settings-modal').classList.add('hidden');
    }
    function updateLicenceDisplay() {
      const el = document.getElementById('settings-licence-display');
      el.textContent = showFullKey ? currentActiveKey : 'EXT-••••••••-FFB832';
    }
    function toggleShowLicence() {
      showFullKey = !showFullKey;
      document.getElementById('btn-show-licence').textContent = showFullKey ? 'hide' : 'show';
      updateLicenceDisplay();
    }
    function toggleVoiceSwitch() {
      voiceEnabled = !voiceEnabled;
      const sw = document.getElementById('voice-switch');
      const knob = document.getElementById('voice-knob');
      const badge = document.getElementById('voice-status-badge');
      if (voiceEnabled) {
        sw.className = 'w-12 h-7 rounded-full bg-purple-500 p-1 transition flex items-center cursor-pointer';
        knob.className = 'w-5 h-5 rounded-full bg-white transition-transform translate-x-5';
        badge.textContent = '• ACTIVATED';
        badge.className = 'px-2.5 py-0.5 rounded-full bg-crimson-500/15 text-crimson-400 text-[10px] font-mono font-bold';
      } else {
        sw.className = 'w-12 h-7 rounded-full bg-zinc-800 p-1 transition flex items-center cursor-pointer';
        knob.className = 'w-5 h-5 rounded-full bg-white transition-transform translate-x-0';
        badge.textContent = '• MUTED';
        badge.className = 'px-2.5 py-0.5 rounded-full bg-white/5 text-zinc-400 text-[10px] font-mono';
      }
    }

    function playVoiceFeedback(phrase) {
      if (!voiceEnabled) return;
      try {
        const key = /desactiv/i.test(phrase) ? 'off' : 'on';
        playSound(key).catch(() => {});
      } catch (e) {}
    }

    let toastTimer = null;
    function showToast(msg) {
      const banner = document.getElementById('toast-banner');
      document.getElementById('toast-text').textContent = msg;
      banner.classList.remove('opacity-0', '-translate-y-2');
      clearTimeout(toastTimer);
      toastTimer = setTimeout(() => {
        banner.classList.add('opacity-0', '-translate-y-2');
      }, 2200);
    }

    document.getElementById('key-input').addEventListener('keydown', (e) => {
      if (e.key === 'Enter') validateKeyInput();
    });

    window.addEventListener('resize', resizeCharacterCanvas);

    const START_MODE = "__START_MODE__"; // "boot" | "skin" — inyectado por Swift

    window.onload = function() {
      if (START_MODE === 'skin') {
        document.getElementById('apple-boot-screen').classList.add('hidden');
        document.getElementById('key-gate-screen').classList.add('hidden');
        document.getElementById('main-panel').classList.remove('hidden');
        document.getElementById('bottom-nav').classList.remove('hidden');
      } else {
        startAppleBootSequence();
      }
      selectStageSlot('BODY');
      renderArsenalList();
      renderStatsWeapons();
      renderCoreLogs();
      resizeCharacterCanvas();
      draw3DCharacter();
      tickArsenalMarker();
    };
  </script>
</body>
</html>
"""#
}
