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
	void v(Train*);
	void v(TemplateVehicle*);

	void v(TemplateVehicle* t)
	{
		if ( !t ) return;

		if (t->first == t)
		{
			std::cout << "template: (ix):" << t->index << std::endl;
			v(t->Next());
		}

		std::cout << "  ix:" << t->index
			<< "  e:" << t->engine_type
			<< "  ty:" << t->type
			<< "  st:" << t->subtype
			<< "  ct:" << t->cargo_type
			<< "  cs:" << t->cargo_subtype
			<< std::endl;
	}

	void v(Train* t)
	{
		if ( !t ) return;

		if (t->First() == t)
		{
			std::cout << "train: (ix):" << t->index << "  (unit):" << t->unitnumber << std::endl;
			v(t->Next());
		}

		std::cout << "  ix:" << t->index
			<< "  e:" << t->engine_type
			<< "  ty:" << t->type
			<< "  st:" << t->subtype
			<< "  ct:" << t->cargo_type
			<< "  cs:" << t->cargo_subtype
			<< "  ca:" << t->cargo.TotalCount()
			<< std::endl;
	}

	void all_trains()
	{
		Train* t;
		FOR_ALL_TRAINS(t)
		{
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
