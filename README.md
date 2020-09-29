# poke-dev

## Setup
```
git clone --recurse-submodules
```

## Build

### Build Docker Image
1. Build image (also builds agbcc compiler/tools)
```
docker build -t pokefirered .
```

## Test
1. Run container
```
docker run -it --rm --name pokefirered pokefirered
```

2. Export ROM from container
```
docker cp <containerId>:/file/path/within/container /host/path/target
```

3. Change ROM permissions from root
```
sudo chown <user> pokefirered_rev1.gba
```

4. Run
```
mgba pokefirered_rev1.gba
```

## Resources
1. Pokefirered: https://github.com/pret/pokefirered/ 
2. Gameboy Dev: https://github.com/gbdev/awesome-gbdev#asm
3. ASM School: http://gameboy.mongenel.com/asmschool.html
4. GB ASM Programming: https://eldred.fr/gb-asm-tutorial/index.html 
5. Gameboy Progamming: https://gb-archive.github.io/salvage/tutorial_de_ensamblador/tutorial_de_ensamblador%20%5BLa%20decadence%5D.html 
