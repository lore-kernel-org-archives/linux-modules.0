Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180826AE0;
	Sat,  7 Sep 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747634; cv=none; b=J89N3r8tDrlW6TQhwnNNSRhTBu0JjtrewYat9hDCZHl/HA+5lqGtkorMrP+IWKG/GIpp/YfAHEKh7Yu4cA1Qy/0KHvOuKLjAhxyvq+KqsqdpWDt9+o90+SPel+E2uBpnjngb5WlAf9grNyccpQGuP+dcv1UVkyTatkgajHZ27JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747634; c=relaxed/simple;
	bh=18QHyOowCoerOI8GyYR6ejC+zvs3qPUSNSXla/8mTQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8y1Fkw/fCO2iukpN2s7GPL5w+0NC201ToZEKEeookgrPFngzFw52EfRGq6a0Kk3OO3KGEXDrKdj3pO4uqd67qRIkD4CY2jOpN1qSYRGyeMtcEHAdnPK5yAeTLzCD4weEGjfpdwTYvvWfniRqbFhZjYDVTcFoGVUO+HUQ4gSkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASUqeBMf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASUqeBMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725747633; x=1757283633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=18QHyOowCoerOI8GyYR6ejC+zvs3qPUSNSXla/8mTQQ=;
  b=ASUqeBMfqSil6jOyEL/B2gMoJPy5FtrlBZU/b0ic47gJzm/GRuEgF3zj
   yO6K7H5DZTw0e+TrfLIwN2QtqocIC2j7DQhQ33+3IjXMXHC9KC3Egqzge
   Y8nBG2Cfhs2oDQJuem/vjVwGM/tOGT3nb6i6MPrhjfcnjz4RI51YsLUDD
   fqSPfCAEZXx16ZZmZ+BAosgbnkpK6OLXPhc+eHf62bLIb8UyeBkcm2IGG
   q5SeUUt3Ba8kzl1MT2Dd3OdQhrHqOJqUYlWENsSRAEg0IzS3v4iVJj48Y
   ZoUA6uoqVEIcJQJ0P+8je4N61JU10gq7bXxIRsI97vXnLk35tWk+p0n48
   w==;
X-CSE-ConnectionGUID: AkvW5oGXSKK03FfX0ZfwAw==
X-CSE-MsgGUID: HoHe/owVQHqYKuPN7m5l1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="27398002"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="27398002"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 15:20:32 -0700
X-CSE-ConnectionGUID: 0o2KY8N/R/OI7fU2DO3w6Q==
X-CSE-MsgGUID: gFO3pKwNQD26MyxnmRlHxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="103750126"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Sep 2024 15:20:29 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn3n8-000D3Q-2V;
	Sat, 07 Sep 2024 22:20:26 +0000
Date: Sun, 8 Sep 2024 06:19:57 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhui Li <chunhui.li@mediatek.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	Chunhui Li <chunhui.li@mediatek.com>,
	Petr Pavlu <petr.pavlu@suse.com>, kernel test robot <lkp@intel.com>,
	Xion Wang <xion.wang@mediatek.com>
Subject: Re: [PATCH v3 1/1] module: abort module loading when sysfs setup
 suffer errors
Message-ID: <202409080534.y2m1URF1-lkp@intel.com>
References: <20240906115748.5367-2-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906115748.5367-2-chunhui.li@mediatek.com>

Hi Chunhui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mcgrof/modules-next]
[also build test WARNING on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhui-Li/module-abort-module-loading-when-sysfs-setup-suffer-errors/20240907-000002
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20240906115748.5367-2-chunhui.li%40mediatek.com
patch subject: [PATCH v3 1/1] module: abort module loading when sysfs setup suffer errors
config: powerpc-asp8347_defconfig (https://download.01.org/0day-ci/archive/20240908/202409080534.y2m1URF1-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080534.y2m1URF1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080534.y2m1URF1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/module/sysfs.c:232:86: warning: non-void function does not return a value [-Wreturn-type]
     232 | static inline int add_sect_attrs(struct module *mod, const struct load_info *info) { }
         |                                                                                      ^
   kernel/module/sysfs.c:234:87: warning: non-void function does not return a value [-Wreturn-type]
     234 | static inline int add_notes_attrs(struct module *mod, const struct load_info *info) { }
         |                                                                                       ^
   2 warnings generated.


vim +232 kernel/module/sysfs.c

   230	
   231	#else /* !CONFIG_KALLSYMS */
 > 232	static inline int add_sect_attrs(struct module *mod, const struct load_info *info) { }
   233	static inline void remove_sect_attrs(struct module *mod) { }
   234	static inline int add_notes_attrs(struct module *mod, const struct load_info *info) { }
   235	static inline void remove_notes_attrs(struct module *mod) { }
   236	#endif /* CONFIG_KALLSYMS */
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
