Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E4157464;
	Sat,  7 Sep 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725713803; cv=none; b=EY3f6gjIIFxz2C97Q21kc/t8N5OGYwrq6jg6X/Z8rcnnERc8IYRNNIwLZhy0XcmDCnezXL5lJLRVweNFxW/BH9WefBogzQBSg48/iJ5DEFkdlkHx55bLoShzywqe2hdpB6FGLoyOjEWPZZhFCgIDrRG9D7BK4P50LZBg/wOnc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725713803; c=relaxed/simple;
	bh=XWYeBfU9YGlnAP8uvAzhTiWCBSzhyADF+d3tbeOseH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC6GB3tHGMze/MbZSKJm/0V+CBGj9SNOEl9FB4zB0Enpk+JmAvWA2KAQIQsm9M5iSVQulEIiHn0IEgNZuBjFlQ0OiC0fItZ0/luBNVUoJkwiemDlAVJkmFa38KCdwzn39rk1Ixz6rG6fVx5+KWt5DZmM4HtVwrafGnx6Mk3klLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2PuZPO1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2PuZPO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725713801; x=1757249801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XWYeBfU9YGlnAP8uvAzhTiWCBSzhyADF+d3tbeOseH4=;
  b=T2PuZPO1Us5GbnJnz9l/5m3QPbHsLLGFy6g6ntZBs81aqCfrQgioSyLn
   C4sX8Mw/51G4eM0K4pdWLhHM41OCx2gnOZW5ltbDPK5Wy6QeZ9wDqXKtV
   vp1uyyMzl50c0FSln+ChSWa4DLG0inCJyHkAbcxyRDJWI+MFfxuvXHKJH
   jcKPMF6SCRaIbqd16eWYtcUKQIRgvi7r82vfqLKDj8ymRD3iTKFyQpB3g
   v3PCcJ2FKBdSCjf8PAXsaO021qe2G0luOa2hlsdWCRIGHPb0cVIbgHort
   9lhvlSLOfnrgETDkg+OIugZHNVZGKsdikDCI/BWYjL05COoJl7NEC0jmA
   A==;
X-CSE-ConnectionGUID: 86BKKJdyRzCwEuouK1Taug==
X-CSE-MsgGUID: pm6venuzTeyU8hWJ6D+pyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35842483"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="35842483"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 05:56:40 -0700
X-CSE-ConnectionGUID: X+D8WBqzQfqefupHhO11nw==
X-CSE-MsgGUID: 9ZBObMzMRZW6VWhwoT8HHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="65850074"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Sep 2024 05:56:37 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smuzT-000CYn-0u;
	Sat, 07 Sep 2024 12:56:35 +0000
Date: Sat, 7 Sep 2024 20:55:44 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhui Li <chunhui.li@mediatek.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	Chunhui Li <chunhui.li@mediatek.com>,
	Petr Pavlu <petr.pavlu@suse.com>, kernel test robot <lkp@intel.com>,
	Xion Wang <xion.wang@mediatek.com>
Subject: Re: [PATCH v3 1/1] module: abort module loading when sysfs setup
 suffer errors
Message-ID: <202409072018.qfEzZbO7-lkp@intel.com>
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
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240907/202409072018.qfEzZbO7-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409072018.qfEzZbO7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409072018.qfEzZbO7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/module/sysfs.c: In function 'add_sect_attrs':
>> kernel/module/sysfs.c:232:67: warning: no return statement in function returning non-void [-Wreturn-type]
     232 | static inline int add_sect_attrs(struct module *mod, const struct load_info *info) { }
         |                                                                   ^~~~~~~~~
   kernel/module/sysfs.c: In function 'add_notes_attrs':
   kernel/module/sysfs.c:234:68: warning: no return statement in function returning non-void [-Wreturn-type]
     234 | static inline int add_notes_attrs(struct module *mod, const struct load_info *info) { }
         |                                                                    ^~~~~~~~~


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
