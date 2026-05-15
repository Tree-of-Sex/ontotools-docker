URIBASE = http://purl.obolibrary.org/obo

ROBOT=robot
# Only TOSO (Tree of Sex Ontology) is loaded in this deployment
ONTS = toso

ONTFILES = $(foreach n, $(ONTS), ontologies/$(n).owl)
IM=monarchinitiative/monarch-ols

# Download and pre-process the ontologies
clean:
	rm -rf ontologies/*

ontologies: $(ONTFILES)

.PHONY: .FORCE

TOSO_URL=https://raw.githubusercontent.com/Tree-of-Sex/ToS-Ontology/refs/heads/develop/toso.owl

ontologies/toso.owl: .FORCE
	@echo "\nDownloading TOSO (develop branch) → $@"
	$(ROBOT) convert -I $(TOSO_URL) -o $@.tmp.owl && mv $@.tmp.owl $@


update-ui:
	wget https://raw.githubusercontent.com/EBISPOT/ols4/refs/heads/dev/frontend/src/components/Footer.tsx -O frontend/Footer.tsx
	wget https://raw.githubusercontent.com/EBISPOT/ols4/refs/heads/dev/frontend/src/components/Header.tsx -O frontend/Header.tsx
	wget https://raw.githubusercontent.com/EBISPOT/ols4/refs/heads/dev/frontend/src/pages/home/Home.tsx -O frontend/Home.tsx
