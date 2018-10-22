/**
 * Debugging features for TBTR
 *
 * I want to keep them out of the git history, so they are just added and removed on the project level.
 * Don't forget to exclude them from commits!
 */

#ifndef TBTR_DEBUG_H
#define TBTR_DEBUG_H

#include <iostream>

#include "stdafx.h"
#include "tbtr_template_vehicle.h"
#include "train.h"
#include "vehicle_base.h"

namespace tbtrdbg
{
	void chain(const Vehicle*);
	template <typename T> void vehicle(const T*);
	void all_trains();
	void all_templates();
}

#endif
