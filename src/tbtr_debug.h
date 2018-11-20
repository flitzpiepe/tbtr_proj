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
	void v(TemplateVehicle* t)
	{
		if ( !t ) return;

		if (t->first == t)
			std::cout << "template: (ix):" << t->index << std::endl;

		std::cout << "  ix:" << t->index
			<< "  e:" << t->engine_type
			<< "  ty:" << t->type
			<< "  st:" << (short)(t->subtype)
			<< "  ct:" << (short)(t->cargo_type)
			<< "  cs:" << (short)(t->cargo_subtype)
			<< "  " << t
			<< std::endl;

		v(t->Next());
	}

	void v(Train* t)
	{
		if ( !t ) return;

		if (t->First() == t)
			std::cout << "train: (ix):" << t->index << "  (unit):" << t->unitnumber << std::endl;

		std::cout << "  ix:" << t->index
			<< "  e:" << t->engine_type
			<< "  ty:" << t->type
			<< "  st:" << (short)(t->subtype)
			<< "  ct:" << (short)(t->cargo_type)
			<< "  cs:" << (short)(t->cargo_subtype)
			<< "  ca:" << t->cargo.TotalCount()
			<< "  " << t
			<< std::endl;

		v(t->Next());
	}

	void all_trains()
	{
		Train* t;
		FOR_ALL_TRAINS(t)
		{
			if (t->First() == t)
				v(t);
		}
	}

	void all_templates()
	{
		TemplateVehicle* tv;
		FOR_ALL_TEMPLATES(tv)
		{
			if (tv->first == tv)
				v(tv);
		}
	}
}

#endif
