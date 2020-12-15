//
// Created by elturpin on 03/12/2020.
//

#pragma once

#include "DnaMutator.h"
#include "Organism.h"
#include "Stats.h"
#include "Threefry.h"
#include <memory>

class Abstract_ExpManager {

public:
  virtual ~Abstract_ExpManager() = default;

  static void create_directory();

  virtual void save(int t) const = 0;

  virtual void load(int t) = 0;

  virtual void run_evolution(int nb_gen) = 0;
};
