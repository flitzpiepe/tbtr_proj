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

namespace td
{
	template<typename T>
	void chain(const T* v)
	{
		if (!v) {
			std::cout << std::endl;
			return;
		}
		std::cout << "\t" << v->index << ":" << v->engine_type;
		chain(v->Next());
	}

	template <typename T>
	void vehicle(const T* v)
	{
		if (!v) return;
		std::cout << "vehicle: " << v->index << ":" << v->type << std::endl;
		chain(v);
	}

	void all_trains()
	{
		Train* t;
		FOR_ALL_TRAINS(t)
		{
			vehicle(t);
		}
	}

	void all_templates()
	{
		TemplateVehicle* tv;
		FOR_ALL_TEMPLATES(tv)
		{
			if (tv->first == tv)
				vehicle(tv);
		}
	}
}

#endif
