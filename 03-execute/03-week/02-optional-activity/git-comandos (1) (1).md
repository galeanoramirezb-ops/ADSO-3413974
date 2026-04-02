# 🚀 Guía de Comandos Git — Rápida y Eficiente

> Git es el sistema de control de versiones más usado del mundo. Esta guía cubre todo lo que necesitas saber, desde lo básico hasta lo avanzado.

---

## 📦 Configuración Inicial

Antes de usar Git por primera vez, configura tu identidad:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
git config --global core.editor "code --wait"   # Editor por defecto (VS Code)
git config --list                                # Ver toda la configuración
```

---

## 🗂️ Crear o Clonar un Repositorio

```bash
git init                          # Inicializar repo en carpeta actual
git init nombre-proyecto          # Crear nueva carpeta e inicializar

git clone <url>                   # Clonar repositorio remoto
git clone <url> nombre-carpeta    # Clonar con nombre personalizado
```

---

## 📋 Estado y Seguimiento de Archivos

```bash
git status                        # Ver estado actual del repo
git status -s                     # Vista compacta del estado

git add archivo.txt               # Agregar un archivo al staging
git add .                         # Agregar TODOS los cambios
git add *.js                      # Agregar todos los .js
git add -p                        # Agregar cambios de forma interactiva

git rm archivo.txt                # Eliminar archivo y registrar en Git
git rm --cached archivo.txt       # Dejar de rastrear (sin borrar el archivo)

git mv viejo.txt nuevo.txt        # Renombrar / mover archivo
```

---

## 💾 Commits

```bash
git commit -m "mensaje claro"             # Commit con mensaje
git commit -am "mensaje"                  # Add + commit (solo archivos rastreados)
git commit --amend -m "nuevo mensaje"     # Modificar el último commit

# Convención recomendada para mensajes:
# feat: nueva funcionalidad
# fix: corrección de bug
# docs: cambios en documentación
# style: formato, espacios
# refactor: reestructura de código
# test: pruebas
# chore: tareas de mantenimiento
```

---

## 🔍 Ver Historial

```bash
git log                           # Historial completo
git log --oneline                 # Una línea por commit
git log --oneline --graph         # Árbol visual de ramas
git log --oneline --all           # Incluye todas las ramas
git log -5                        # Últimos 5 commits
git log --author="Nombre"         # Commits de un autor
git log --since="2024-01-01"      # Commits desde una fecha
git log -- archivo.txt            # Historial de un archivo

git show <hash>                   # Ver detalles de un commit
git show HEAD                     # Ver el último commit
git diff                          # Cambios no en staging
git diff --staged                 # Cambios en staging vs último commit
git diff <rama1> <rama2>          # Diferencias entre ramas
```

---

## 🌿 Ramas (Branches)

```bash
git branch                        # Listar ramas locales
git branch -a                     # Listar todas (incluye remotas)
git branch nombre-rama            # Crear rama
git branch -d nombre-rama         # Eliminar rama (seguro)
git branch -D nombre-rama         # Eliminar rama (forzado)
git branch -m viejo nuevo         # Renombrar rama

git switch nombre-rama            # Cambiar a una rama ✅ (moderno)
git switch -c nueva-rama          # Crear y cambiar a nueva rama ✅
git checkout nombre-rama          # Cambiar rama (clásico)
git checkout -b nueva-rama        # Crear y cambiar (clásico)
```

---

## 🔀 Merge y Rebase

```bash
# MERGE — Une dos ramas creando un commit de fusión
git merge nombre-rama             # Merge de rama al branch actual
git merge --no-ff nombre-rama     # Forzar commit de merge (sin fast-forward)
git merge --abort                 # Cancelar merge en conflicto

# REBASE — Reescribe el historial aplicando commits encima de otra base
git rebase main                   # Rebase del branch actual sobre main
git rebase --abort                # Cancelar rebase
git rebase --continue             # Continuar tras resolver conflicto
git rebase -i HEAD~3              # Rebase interactivo de últimos 3 commits
```

> 💡 **Regla de oro**: Usa `merge` para ramas compartidas, `rebase` para limpiar historial local.

---

## 🏷️ Etiquetas (Tags)

```bash
git tag                           # Listar tags
git tag v1.0.0                    # Crear tag ligero
git tag -a v1.0.0 -m "Release"    # Crear tag anotado
git tag -a v1.0.0 <hash>          # Tag en un commit específico
git push origin v1.0.0            # Publicar tag
git push origin --tags            # Publicar todos los tags
git tag -d v1.0.0                 # Eliminar tag local
```

---

## ☁️ Repositorios Remotos

```bash
git remote -v                          # Ver remotos configurados
git remote add origin <url>            # Agregar remoto
git remote rename origin upstream      # Renombrar remoto
git remote remove origin               # Eliminar remoto

git fetch                              # Descargar cambios SIN aplicar
git fetch --all                        # Fetch de todos los remotos
git pull                               # Fetch + merge automático
git pull --rebase                      # Fetch + rebase (historial limpio)

git push origin main                   # Subir rama al remoto
git push -u origin nombre-rama         # Subir y configurar upstream
git push --force-with-lease            # Push forzado (más seguro)
git push origin --delete nombre-rama   # Eliminar rama remota
```

---

## 📦 Stash — Guardar cambios temporalmente

```bash
git stash                         # Guardar cambios actuales
git stash push -m "descripción"   # Guardar con nombre
git stash list                    # Ver lista de stashes
git stash pop                     # Aplicar y eliminar el último stash
git stash apply stash@{2}         # Aplicar un stash específico
git stash drop stash@{0}          # Eliminar un stash
git stash clear                   # Eliminar todos los stashes
git stash branch nueva-rama       # Crear rama desde stash
```

---

## ⏪ Deshacer Cambios

```bash
# Deshacer en el área de trabajo (sin afectar staging)
git restore archivo.txt           # Descartar cambios locales ✅
git checkout -- archivo.txt       # Igual (clásico)

# Sacar del staging
git restore --staged archivo.txt  # Quitar del staging ✅
git reset HEAD archivo.txt        # Igual (clásico)

# Deshacer commits
git reset --soft HEAD~1           # Deshace commit, cambios quedan en staging
git reset --mixed HEAD~1          # Deshace commit, cambios quedan sin staging
git reset --hard HEAD~1           # ⚠️ Elimina commit y cambios (irreversible)

git revert <hash>                 # Crea commit que deshace otro (seguro en remoto)
git revert HEAD                   # Revertir el último commit

git clean -fd                     # ⚠️ Eliminar archivos no rastreados
```

---

## 🍒 Cherry-pick

```bash
git cherry-pick <hash>            # Copiar un commit específico al branch actual
git cherry-pick <hash1> <hash2>   # Copiar varios commits
git cherry-pick A..B              # Copiar rango de commits
git cherry-pick --abort           # Cancelar cherry-pick
```

---

## 🔎 Buscar en el Historial

```bash
git grep "texto"                  # Buscar texto en archivos rastreados
git log -S "función"              # Commits donde aparece/desaparece el texto
git log -G "regex"                # Commits que coinciden con regex
git blame archivo.txt             # Ver quién modificó cada línea
git bisect start                  # Iniciar búsqueda binaria de bug
git bisect bad                    # Marcar commit actual como malo
git bisect good <hash>            # Marcar commit como bueno
git bisect reset                  # Terminar bisect
```

---

## ⚙️ Alias Útiles

Agrega estos a tu configuración para mayor velocidad:

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.unstage "restore --staged"
```

Uso: `git lg`, `git st`, `git undo`

---

## 🗺️ Flujo de Trabajo Recomendado (Git Flow simplificado)

```
main          ──────●──────────────────────●── (producción)
                    │                      │
develop       ──────●──────●──────●────────● (integración)
                           │      │
feature/login        ──────●      │
feature/dashboard               ──●
```

```bash
# 1. Crear rama para nueva funcionalidad
git switch -c feature/login

# 2. Trabajar, hacer commits
git add .
git commit -m "feat: agregar formulario de login"

# 3. Actualizar con cambios de develop
git fetch origin
git rebase origin/develop

# 4. Merge a develop
git switch develop
git merge --no-ff feature/login

# 5. Eliminar rama
git branch -d feature/login
```

---

## 🚨 Comandos de Emergencia

| Situación | Comando |
|-----------|---------|
| Subí algo que no debía | `git revert <hash>` + `git push` |
| Olvidé agregar algo al último commit | `git add . && git commit --amend` |
| Necesito cambiar de rama con cambios | `git stash` → `switch` → `stash pop` |
| Perdí commits con `reset --hard` | `git reflog` → `git reset --hard <hash>` |
| Conflicto imposible de resolver | `git merge --abort` o `git rebase --abort` |

---

## 📌 Referencia Rápida — Estados de un archivo

```
Untracked  →  git add  →  Staged  →  git commit  →  Committed
                                                         │
                         git restore --staged  ◄─────────┘
         git restore ◄───────────────────────────────────┘
```

---

> 📚 **Recursos adicionales**: [git-scm.com/doc](https://git-scm.com/doc) · [learngitbranching.js.org](https://learngitbranching.js.org)
