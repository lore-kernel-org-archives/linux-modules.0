Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548A415B6B
	for <linux-modules@vger.kernel.org>; Wed, 19 Aug 2026 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166858; cv=none; b=JYE8TiCgZqYtysJql1wSBHqznzgVuUSCFqKUIBzFeu1l0R/RbCEXT6FqQdODfzUS19GxdAz4XdcspQoT+4OcSjqGoPKQcgv9hbR6FeiQ4LfYOHWxJjG1l0PGSzVHmgnvFe7krYGDcDvWj8LVVpl4Un3W6jRsUSC8sr/awuDPkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166858; c=relaxed/simple;
	bh=+ZFZ5TR2JVZvoBSxwFI1oXIzKXgpVvNL9wT046mQVYo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WEW3f88t0YTrmjfT1BryWhyHyNpwHGj186YG9t0FZriaar50cGsoFWVwvqck79u5KVJxcWHDhcYm8j9djATvmJ76cXCnD5HorBNYounw4rsrU1I3pb187rP/sjwXxFvsEEwxidZydIDCJYwe/JE8a0JHzM4X5alYBOvqGj4azeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRKpL6S8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRKpL6S8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787166856; x=1818702856;
  h=date:from:to:cc:subject:message-id;
  bh=+ZFZ5TR2JVZvoBSxwFI1oXIzKXgpVvNL9wT046mQVYo=;
  b=gRKpL6S80hzbvEXyjYhe/BEmGpl2nwy5phBIf9KpCwHKxCsa59eFw/7m
   ohHbSfpC2sLc+gY/YMGRn16Wio98Q/skWl4cFA86JbcaG9JK37Xzv8N3m
   iWsSqvsp+33gjIJeLJFCvxesDM9l/50L+JIJe56qpgY91BjNpKNSrN6VF
   OhfGNxuDsxcYH9z/6A8uH2Ro2b91B120DFSBDVAfvDO4txC1W0LxSdOVg
   87Yz7GrTyGHTchKgq4BEozISPuaBDiQkspAcJyGG9JBZztkR6BJwK86iH
   yzOdk+Vf2R43A7Dz+MmjuTbjFcxksPPASR3iClfUir9zwvDtR/i0PIc0G
   g==;
X-CSE-ConnectionGUID: 5u1nGlH+RtmT3YIlOyP1TQ==
X-CSE-MsgGUID: daw/9ygPSDO+KEbK9zAihA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87812965"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87812965"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 12:14:14 -0700
X-CSE-ConnectionGUID: O3KL05QzSxiNUI4lan6qhA==
X-CSE-MsgGUID: Mf+X+82hSB+jUDZxrZYunQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269922729"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 19 Aug 2026 12:14:11 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwljl-000000007OP-0aiB;
	Wed, 19 Aug 2026 19:14:09 +0000
Date: Wed, 19 Aug 2026 21:13:59 +0200
From: kernel test robot <lkp@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org
Subject: [modules:ppavlu-module-include 32/37]
 mm/page_alloc.c:6949:9: error: implicit declaration of function
 'DEFINE_DYNAMIC_DEBUG_METADATA'
Message-ID: <202608192101.kKGUiLuV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git ppavlu-module-include
head:   fcbfd3cbe0a054838436812cc0b664f71ba1d0a4
commit: 1c6a138c5d5c9156a13a7d82df4f2fec5c2b71a2 [32/37] WIP: module: Avoid including linux/dynamic_debug in linux/module.h
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260819/202608192101.kKGUiLuV-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260819/202608192101.kKGUiLuV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608192101.kKGUiLuV-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_alloc.c: In function 'alloc_contig_dump_pages':
>> mm/page_alloc.c:6949:9: error: implicit declaration of function 'DEFINE_DYNAMIC_DEBUG_METADATA' [-Wimplicit-function-declaration]
    6949 |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page_alloc.c:6949:39: error: 'descriptor' undeclared (first use in this function)
    6949 |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
         |                                       ^~~~~~~~~~
   mm/page_alloc.c:6949:39: note: each undeclared identifier is reported only once for each function it appears in
>> mm/page_alloc.c:6951:13: error: implicit declaration of function 'DYNAMIC_DEBUG_BRANCH' [-Wimplicit-function-declaration]
    6951 |         if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
         |             ^~~~~~~~~~~~~~~~~~~~


vim +/DEFINE_DYNAMIC_DEBUG_METADATA +6949 mm/page_alloc.c

4aa4abf1f14bd6 Ryan Roberts    2026-04-01  6944  
8df995f6bde01d Alexandre Ghiti 2019-05-13  6945  #ifdef CONFIG_CONTIG_ALLOC
a1394bddf9b60e Minchan Kim     2021-04-29  6946  /* Usage: See admin-guide/dynamic-debug-howto.rst */
a1394bddf9b60e Minchan Kim     2021-04-29  6947  static void alloc_contig_dump_pages(struct list_head *page_list)
a1394bddf9b60e Minchan Kim     2021-04-29  6948  {
a1394bddf9b60e Minchan Kim     2021-04-29 @6949  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
a1394bddf9b60e Minchan Kim     2021-04-29  6950  
a1394bddf9b60e Minchan Kim     2021-04-29 @6951  	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
a1394bddf9b60e Minchan Kim     2021-04-29  6952  		struct page *page;
a1394bddf9b60e Minchan Kim     2021-04-29  6953  
a1394bddf9b60e Minchan Kim     2021-04-29  6954  		dump_stack();
a1394bddf9b60e Minchan Kim     2021-04-29  6955  		list_for_each_entry(page, page_list, lru)
a1394bddf9b60e Minchan Kim     2021-04-29  6956  			dump_page(page, "migration failure");
a1394bddf9b60e Minchan Kim     2021-04-29  6957  	}
a1394bddf9b60e Minchan Kim     2021-04-29  6958  }
a1394bddf9b60e Minchan Kim     2021-04-29  6959  

:::::: The code at line 6949 was first introduced by commit
:::::: a1394bddf9b60e96d075d94b71a8857696598186 mm: page_alloc: dump migrate-failed pages

:::::: TO: Minchan Kim <minchan@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
