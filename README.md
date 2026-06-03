# 🏆 Prono Mundial 2026

Application de pronostics pour la Coupe du Monde 2026 — entre collègues, temps réel.

## Stack
- **Frontend** : HTML/CSS/JS pur (zéro dépendance build)
- **Base de données** : Supabase (PostgreSQL gratuit)
- **Hébergement** : Vercel (gratuit)

---

## 🚀 Setup en 4 étapes

### Étape 1 — Créer le projet Supabase

1. Va sur [supabase.com](https://supabase.com) → **Start your project**
2. Connecte-toi avec GitHub
3. Clique **New project**, choisis un nom (ex: `cdm2026`), une région (West EU), un mot de passe
4. Attends ~2 minutes que le projet démarre

### Étape 2 — Créer la base de données

1. Dans Supabase, clique sur **SQL Editor** (icône base de données à gauche)
2. Clique **New query**
3. Copie-colle tout le contenu du fichier `sql/schema.sql`
4. Clique **Run** (▶)
5. Tu dois voir "Success. No rows returned" → c'est bon !

### Étape 3 — Récupérer les clés Supabase

1. Dans Supabase, va dans **Settings** → **API**
2. Copie :
   - **Project URL** → `https://xxxxxxxxxxxx.supabase.co`
   - **anon public** key → `eyJhbGci...`

### Étape 4 — Déployer sur Vercel

1. Va sur [vercel.com](https://vercel.com) → connecte-toi avec GitHub
2. Crée un nouveau repo GitHub avec ces fichiers (ou importe ce dossier)
3. Dans Vercel → **Add New Project** → importe le repo
4. Clique **Deploy** (pas besoin de configurer quoi que ce soit)
5. Vercel te donne une URL comme `cdm2026-xyz.vercel.app`

### C'est tout !

Partage l'URL à tes collègues. Au premier accès, chacun entre les clés Supabase
(URL + anon key) — elles sont sauvegardées localement dans leur navigateur.

---

## 🎮 Comment jouer

1. **Onglet JOUEURS** — Ajoute les noms de chaque participant
2. **Onglet MATCHS** — Chaque joueur saisit ses pronos avant le coup d'envoi
3. **Résultats** — L'admin saisit le vrai score après chaque match
4. **CLASSEMENT** — Podium et tableau mis à jour en temps réel

## Points
| Situation | Groupes | Élimination directe |
|-----------|---------|---------------------|
| Score exact | 3 pts | 6 pts |
| Bon vainqueur/nul | 1 pt | 3 pts |
| Mauvais résultat | 0 pt | 0 pt |

---

## 💡 Partager les clés Supabase facilement

Pour éviter que chaque collègue entre les clés manuellement, tu peux créer un lien
avec les paramètres pré-remplis en ajoutant à ton URL :

```
https://cdm2026-xyz.vercel.app?url=TON_URL_SUPABASE&key=TA_ANON_KEY
```

L'app détecte ces paramètres et se connecte automatiquement.
