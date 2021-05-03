# studyforrest.org Dataset

[![made-with-datalad](https://www.datalad.org/badges/made_with.svg)](https://datalad.org)
[![PDDL-licensed](https://img.shields.io/badge/license-PDDL-blue.svg)](http://opendatacommons.org/licenses/pddl/summary)
[![No registration or authentication required](https://img.shields.io/badge/data_access-unrestricted-green.svg)]()
[![doi](https://img.shields.io/badge/doi-missing-lightgrey.svg)](http://dx.doi.org/)

## Localization of higher-level visual ROIs

For all participants in the phase2 extension of the studyforrest dataset, the
following visual areas were localized:

- fusiform face area (FFA)
- occipital face area (OFA)
- parahippocampal place area (PPA)
- extrastriate body area (EBA)
- lateral occipital complex (LOC)
- early visual cortex (VIS)

More information on the procedure and the results can be found in:

Ayan Sengupta, Falko R. Kaule, J. Swaroop Guntupalli, Michael B. Hoffmann,
Christian Häusler, Jörg Stadler, Michael Hanke.
[An extension of the studyforrest dataset for vision research](http://biorxiv.org/content/early/2016/03/31/046573).
(submitted for publication)

For further information about the project visit: http://studyforrest.org

## Content

``code/``:
   all source code to perform the analysis of the block-design
   localizer fMRI data

``src/``:
   links to repositories containing all inputs for the analysis

``sub-??/``:
   analysis results per participant

   ``onsets/``:
     per-stimulus condition timing in FSL's EV3 format (converted from the BIDS
     event specifications)

   ``2ndlvl.gfeat/``:
     Full output folder of the 2nd level fixed-effects analysis aggregating
     1st-level GLM parameters across all four experiment runs. This contains
     thresholded and unthresholded Z-stat maps which were the basis for the
     subsequent titration of ROI masks per participant.

   ``rois/``:
     One mask volume per isolated voxel cluster in the results. Each filename
     starts with the ROI label (e.g. lFFA for left fusiform face area). There
     can be more than one file/cluster per ROI per subject, if more than one
     isolated voxel cluster was present in the results.

## How to obtain the data files

This repository is a [DataLad](https://www.datalad.org/) dataset. It provides
fine-grained data access down to the level of individual files, and allows for
tracking future updates. In order to use this repository for data retrieval,
[DataLad](https://www.datalad.org/) is required. It is a free and
open source command line tool, available for all major operating
systems, and builds up on Git and [git-annex](https://git-annex.branchable.com/)
to allow sharing, synchronizing, and version controlling collections of
large files. You can find information on how to install DataLad at
[handbook.datalad.org/en/latest/intro/installation.html](http://handbook.datalad.org/en/latest/intro/installation.html).


### Get the dataset

A DataLad dataset can be `cloned` by running

```
datalad clone <url>
```

Once a dataset is cloned, it is a light-weight directory on your local machine.
At this point, it contains only small metadata and information on the
identity of the files in the dataset, but not actual *content* of the
(sometimes large) data files.


### Retrieve dataset content

After cloning a dataset, you can retrieve file contents by running

```
datalad get <path/to/directory/or/file>`
```

This command will trigger a download of the files, directories, or
subdatasets you have specified.

DataLad datasets can contain other datasets, so called *subdatasets*.
If you clone the top-level dataset, subdatasets do not yet contain
metadata and information on the identity of files, but appear to be
empty directories. In order to retrieve file availability metadata in
subdatasets, run

```
datalad get -n <path/to/subdataset>
```

Afterwards, you can browse the retrieved metadata to find out about
subdataset contents, and retrieve individual files with `datalad get`.
If you use `datalad get <path/to/subdataset>`, all contents of the
subdataset will be downloaded at once.


### Stay up-to-date

DataLad datasets can be updated. The command `datalad update` will
*fetch* updates and store them on a different branch (by default
`remotes/origin/master`). Running

```
datalad update --merge
```

will *pull* available updates and integrate them in one go.


### More information

More information on DataLad and how to use it can be found in the DataLad Handbook at
[handbook.datalad.org](http://handbook.datalad.org/en/latest/index.html). The chapter
"DataLad datasets" can help you to familiarize yourself with the concept of a dataset.
