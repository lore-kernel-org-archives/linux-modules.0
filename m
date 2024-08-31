Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582118E11;
	Sat, 31 Aug 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725120797; cv=none; b=NFarVbmh087Gg60zKr/Ey/QVgVaKNX4wqBDamVl0A8cSdBzOrcVlCcYsH1rpQ4mzmZTUAALkupsuDxetExDC0O+Tv85kyFD9j1NYJ6X358hrpR5eTAxAA+wIsfLQdhSiti7G6n3u4guQ3qCJTEkTX1ivfyjpd23krLBkp6SHzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725120797; c=relaxed/simple;
	bh=V3PH/iwNcUY5XOXUetc7AOO6fwQ8F1FmwYao+OX2WxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZD3jPEnoKREWYF+o4x2S5cuY3due67Ha1Mc80ULhWVozaciUeolKZGEkdNEYh1im2pA7lKwk+E2zg7nmmCs2C4AZMt4f25A4tRaHke+58UvZYP9HtD0JfNgHve5ejQg8W6v+iZ5HZslS48mW49lzH9XEU4taGwPOEQSxs7sME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA6V0u9S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA6V0u9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725120795; x=1756656795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3PH/iwNcUY5XOXUetc7AOO6fwQ8F1FmwYao+OX2WxQ=;
  b=dA6V0u9SBTKK6/7XYJY2Pc+knWjbjtTqZliI1hOHtzHTWyTi1wdv/qby
   HRC//CzzVmNbDIzsmpzI/G/IhZ62t7+yWGidq4SBY7q8mnEq1VuJUcrfT
   X2tWJSOczLC2iwgnVMlGC8C2I7UpK8eojRbJzc9lPQODsI1IOfZe3WXhm
   NaZoho28MptmYLca6OwlR3XUvIi8UQ0DhYvS8lPORqIr/TGmKvVAQQBQb
   adtAEofchTeNUDKvUuCcM0wHsrkYZFojnBsjk1Gzky7gn7q1GVi0i5sGV
   +7vyukRsJK7IDNcykf5YbfmXSOZrYlZqBpiD+eNTBZA59Y2QpW3p3bncP
   A==;
X-CSE-ConnectionGUID: jt76MWfFRr2O4LftkmSnlw==
X-CSE-MsgGUID: bxo+FslqSDqjPete+ue4PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23934308"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="23934308"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 09:13:15 -0700
X-CSE-ConnectionGUID: Nxv4tAiMQmCtOKeyqJ/uoQ==
X-CSE-MsgGUID: tWREeUztRS6E15J6ZG+5AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="64681651"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Aug 2024 09:13:13 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skQir-0002uM-2s;
	Sat, 31 Aug 2024 16:13:09 +0000
Date: Sun, 1 Sep 2024 00:12:14 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhui Li <chunhui.li@mediatek.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	Chunhui Li <chunhui.li@mediatek.com>,
	Xion Wang <xion.wang@mediatek.com>
Subject: Re: [PATCH] module: abort module loading when sysfs setup suffer
 errors
Message-ID: <202409010016.3XIFSmRA-lkp@intel.com>
References: <20240830054400.26622-1-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830054400.26622-1-chunhui.li@mediatek.com>

Hi Chunhui,

kernel test robot noticed the following build errors:

[auto build test ERROR on mcgrof/modules-next]
[also build test ERROR on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhui-Li/module-abort-module-loading-when-sysfs-setup-suffer-errors/20240830-134417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20240830054400.26622-1-chunhui.li%40mediatek.com
patch subject: [PATCH] module: abort module loading when sysfs setup suffer errors
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240901/202409010016.3XIFSmRA-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409010016.3XIFSmRA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409010016.3XIFSmRA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/module/sysfs.c: In function 'mod_sysfs_setup':
>> kernel/module/sysfs.c:400:13: error: void value not ignored as it ought to be
     400 |         err = add_sect_attrs(mod, info);
         |             ^
   kernel/module/sysfs.c:404:13: error: void value not ignored as it ought to be
     404 |         err = add_notes_attrs(mod, info);
         |             ^


vim +400 kernel/module/sysfs.c

   370	
   371	int mod_sysfs_setup(struct module *mod,
   372			    const struct load_info *info,
   373				   struct kernel_param *kparam,
   374				   unsigned int num_params)
   375	{
   376		int err;
   377	
   378		err = mod_sysfs_init(mod);
   379		if (err)
   380			goto out;
   381	
   382		mod->holders_dir = kobject_create_and_add("holders", &mod->mkobj.kobj);
   383		if (!mod->holders_dir) {
   384			err = -ENOMEM;
   385			goto out_unreg;
   386		}
   387	
   388		err = module_param_sysfs_setup(mod, kparam, num_params);
   389		if (err)
   390			goto out_unreg_holders;
   391	
   392		err = module_add_modinfo_attrs(mod);
   393		if (err)
   394			goto out_unreg_param;
   395	
   396		err = add_usage_links(mod);
   397		if (err)
   398			goto out_unreg_modinfo_attrs;
   399	
 > 400		err = add_sect_attrs(mod, info);
   401		if (err)
   402			goto out_unreg_sect_attrs;
   403	
   404		err = add_notes_attrs(mod, info);
   405		if (err)
   406			goto out_unreg_notes_attrs;
   407	
   408		return 0;
   409	
   410	out_unreg_notes_attrs:
   411		remove_notes_attrs(mod);
   412	out_unreg_sect_attrs:
   413		remove_sect_attrs(mod);
   414	out_unreg_modinfo_attrs:
   415		module_remove_modinfo_attrs(mod, -1);
   416	out_unreg_param:
   417		module_param_sysfs_remove(mod);
   418	out_unreg_holders:
   419		kobject_put(mod->holders_dir);
   420	out_unreg:
   421		mod_kobject_put(mod);
   422	out:
   423		return err;
   424	}
   425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
