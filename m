Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] depmod: fix errorpath memleaks in report cycles logic
References: <20170320100951.20884-1-yauheni.kaliuta@redhat.com>
Date: Mon, 20 Mar 2017 12:28:16 +0200
In-Reply-To: <20170320100951.20884-1-yauheni.kaliuta@redhat.com> (Yauheni
	Kaliuta's message of "Mon, 20 Mar 2017 12:09:51 +0200")
Message-ID: <xunyk27kgs3j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi!

>>>>> On Mon, 20 Mar 2017 12:09:51 +0200, Yauheni Kaliuta  wrote:

 > From: Yauheni Kaliuta <y.kaliuta@gmail.com>

Ooops. Could you please remove the line? ;)

 > The c7ce9f0c80f3d561078a78205a14c5ba7663cfdd commit (depmod:
 > handle nested loops) introduced a bunch of possible memory leaks
 > in error path. In the real world scenario it is not a problem,
 > since the utility quits if it detects any of the errors, but from
 > the programming point of view, it is not nice. So, add the
 > cleanups.

 > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 > ---
 >  tools/depmod.c | 54 +++++++++++++++++++++++++++++++++++++-----------------
 >  1 file changed, 37 insertions(+), 17 deletions(-)

 > diff --git a/tools/depmod.c b/tools/depmod.c
 > index 116adbeb14a0..7f9e9804787e 100644
 > --- a/tools/depmod.c
 > +++ b/tools/depmod.c
 > @@ -1481,10 +1481,10 @@ static void depmod_list_remove_data(struct kmod_list **list, void *data)
 >  	*list = l;
 >  }
 
 > -static void depmod_report_one_cycle(struct depmod *depmod,
 > -				    struct vertex *vertex,
 > -				    struct kmod_list **roots,
 > -				    struct hash *loop_set)
 > +static int depmod_report_one_cycle(struct depmod *depmod,
 > +				   struct vertex *vertex,
 > +				   struct kmod_list **roots,
 > +				   struct hash *loop_set)
 >  {
 >  	const char sep[] = " -> ";
 >  	size_t sz;
 > @@ -1493,6 +1493,7 @@ static void depmod_report_one_cycle(struct depmod *depmod,
 >  	int i;
 >  	int n;
 >  	struct vertex *v;
 > +	int rc;
 
 >  	array_init(&reverse, 3);
 
 > @@ -1503,7 +1504,10 @@ static void depmod_report_one_cycle(struct depmod *depmod,
 
 >  		sz += v->mod->modnamesz - 1;
 >  		array_append(&reverse, v);
 > -		hash_add(loop_set, v->mod->modname, NULL);
 > +		rc = hash_add(loop_set, v->mod->modname, NULL);
 > +		if (rc != 0)
 > +			return rc;
 > +		/* the hash will be freed where created */
 >  	}
 >  	sz += vertex->mod->modnamesz - 1;
 
 > @@ -1528,6 +1532,8 @@ static void depmod_report_one_cycle(struct depmod *depmod,
 
 >  	free(buf);
 >  	array_free_array(&reverse);
 > +
 > +	return 0;
 >  }
 
 >  static int depmod_report_cycles_from_root(struct depmod *depmod,
 > @@ -1545,17 +1551,18 @@ static int depmod_report_cycles_from_root(struct depmod *depmod,
 >  	struct mod *m;
 >  	struct mod **itr, **itr_end;
 >  	size_t is;
 > +	int ret = -ENOMEM;
 
 >  	root = vertex_new(root_mod, NULL);
 >  	if (root == NULL) {
 >  		ERR("No memory to report cycles\n");
 > -		return -ENOMEM;
 > +		goto out;
 >  	}
 
 >  	l = kmod_list_append(free_list, root);
 >  	if (l == NULL) {
 >  		ERR("No memory to report cycles\n");
 > -		return -ENOMEM;
 > +		goto out;
 >  	}
 >  	free_list = l;
 
 > @@ -1570,8 +1577,13 @@ static int depmod_report_cycles_from_root(struct depmod *depmod,
 >  		 * from part of a loop or from a branch after a loop
 >  		 */
 >  		if (m->visited && m == root->mod) {
 > -			depmod_report_one_cycle(depmod, vertex,
 > -						roots, loop_set);
 > +			int rc;
 > +			rc = depmod_report_one_cycle(depmod, vertex,
 > +						     roots, loop_set);
 > +			if (rc != 0) {
 > +				ret = rc;
 > +				goto out;
 > +			}
 >  			continue;
 >  		}
 
 > @@ -1598,7 +1610,7 @@ static int depmod_report_cycles_from_root(struct depmod *depmod,
 >  			v = vertex_new(dep, vertex);
 >  			if (v == NULL) {
 >  				ERR("No memory to report cycles\n");
 > -				return -ENOMEM;
 > +				goto out;
 >  			}
 >  			assert(is < stack_size);
 >  			stack[is++] = v;
 > @@ -1606,12 +1618,15 @@ static int depmod_report_cycles_from_root(struct depmod *depmod,
 >  			l = kmod_list_append(free_list, v);
 >  			if (l == NULL) {
 >  				ERR("No memory to report cycles\n");
 > -				return -ENOMEM;
 > +				goto out;
 >  			}
 >  			free_list = l;
 
 >  		}
 >  	}
 > +	ret = 0;
 > +
 > +out:
 >  	while (free_list) {
 >  		v = free_list->data;
 >  		l = kmod_list_remove(free_list);
 > @@ -1619,7 +1634,7 @@ static int depmod_report_cycles_from_root(struct depmod *depmod,
 >  		free(v);
 >  	}
 
 > -	return 0;
 > +	return ret;
 >  }
 
 >  static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 > @@ -1643,7 +1658,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >  		l = kmod_list_append(roots, m);
 >  		if (l == NULL) {
 >  			ERR("No memory to report cycles\n");
 > -			return;
 > +			goto out_list;
 >  		}
 >  		roots = l;
 >  		n_r++;
 > @@ -1652,13 +1667,13 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >  	stack = malloc(n_r * sizeof(void *));
 >  	if (stack == NULL) {
 >  		ERR("No memory to report cycles\n");
 > -		return;
 > +		goto out_list;
 >  	}
 
 >  	loop_set = hash_new(16, NULL);
 >  	if (loop_set == NULL) {
 >  		ERR("No memory to report cycles\n");
 > -		return;
 > +		goto out_list;
 >  	}
 
 >  	while (roots != NULL) {
 > @@ -1670,14 +1685,19 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >  						     &roots,
 >  						     stack, n_r, loop_set);
 >  		if (err < 0)
 > -			goto err;
 > +			goto out_hash;
 >  	}
 
 >  	num_cyclic = hash_get_count(loop_set);
 >  	ERR("Found %d modules in dependency cycles!\n", num_cyclic);
 
 > -err:
 > +out_hash:
 >  	hash_free(loop_set);
 > +out_list:
 > +	while (roots != NULL) {
 > +		/* no need to free data, come from outside */
 > +		roots = kmod_list_remove(roots);
 > +	}
 >  }
 
 >  static int depmod_calculate_dependencies(struct depmod *depmod)
 > -- 
 > 2.9.2.368.g08bb350

 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-modules" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
WBR,
Yauheni Kaliuta
