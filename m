Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AF26ED4F
	for <linux-modules@vger.kernel.org>; Wed, 19 Aug 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183957; cv=none; b=XWGHsy9wABU8nvICR4w5jGQqKcmxhsJ6Lx58ayt6XJXr5LGrUQS4BEAf89CUr6kWNUhd1jt8eaFXJD3Pug39O5OtFTeIHDc5tEk0OdorN8UUa95FXilTdG/3ONtShV63Nx/yu8+sr6glKaIkU8C/CV7riW1q0dHQk8QWGqwmulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183957; c=relaxed/simple;
	bh=+2BvtNv4XwMOy86djj9xd1rItPsVO4KoSyVuwUTvHpc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PK6VyeVIgg8qYNmxDJHcrk/DptqNDIAF64zPdz8vLtwO6xDPrKNuhVIN2CREvxmaxpqorH09ooZwUKqT3ZKWBFSKdETsZ7VnB05sd24Rn0uZY3YFHvcdyp855+zmjnpuLrJzj1luDl9fRTs1Xfhxra0yj6dOVXis36aOkb0tXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dm3TCisy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dm3TCisy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787183956; x=1818719956;
  h=date:from:to:cc:subject:message-id;
  bh=+2BvtNv4XwMOy86djj9xd1rItPsVO4KoSyVuwUTvHpc=;
  b=dm3TCisyGLq7a9K2cLpSiPkXBQ3XglMX5flEcgh0UB38Oicn3l9q4eC8
   BvoROI+MujKWeijP0vnVtCvIQQvHyjLfCsYZXdGxdKITLoXIaQ5iAkd4V
   eVtcJ4PiGPOMuZgQ2w7kX+xntapJtZKtcle86XapnpxsBxnATeINW2nTI
   4rrKmKEG4PlhtI4qB/1a76dnjtrvfUpTD2PusUQhpe2ZGVPkWvB6p4cCy
   wh/f3OgJg64fTlkrie8dvA5m45/YrH+bI5VWo/GgwUJxl86BtdqVvWNAB
   nqB3K+25OzuLGgJiz2r+65q5D4AcEG20Lq4JPgx7ytczZ7BFFAP3Pj3jZ
   A==;
X-CSE-ConnectionGUID: lZGSjaNgQjKCR8mluwG6gA==
X-CSE-MsgGUID: +5Q0JDUcSoaD9NHKQcgryQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91521594"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="91521594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:59:15 -0700
X-CSE-ConnectionGUID: K3EhypeaTDyr4RZbcHLeyQ==
X-CSE-MsgGUID: 14xvftHPTcKb5NXGqPK1lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="264416162"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 19 Aug 2026 16:59:12 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwqBa-000000007Px-28n6;
	Wed, 19 Aug 2026 23:59:10 +0000
Date: Thu, 20 Aug 2026 01:58:31 +0200
From: kernel test robot <lkp@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org
Subject: [modules:ppavlu-module-include 32/37]
 mm/page_alloc.c:6949:2: error: call to undeclared function
 'DEFINE_DYNAMIC_DEBUG_METADATA'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202608200157.w2LJC8K6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git ppavlu-module-include
head:   fcbfd3cbe0a054838436812cc0b664f71ba1d0a4
commit: 1c6a138c5d5c9156a13a7d82df4f2fec5c2b71a2 [32/37] WIP: module: Avoid including linux/dynamic_debug in linux/module.h
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260820/202608200157.w2LJC8K6-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608200157.w2LJC8K6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608200157.w2LJC8K6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/page_alloc.c:6949:2: error: call to undeclared function 'DEFINE_DYNAMIC_DEBUG_METADATA'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    6949 |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
         |         ^
>> mm/page_alloc.c:6949:32: error: use of undeclared identifier 'descriptor'
    6949 |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
         |                                       ^~~~~~~~~~
>> mm/page_alloc.c:6951:6: error: call to undeclared function 'DYNAMIC_DEBUG_BRANCH'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    6951 |         if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
         |             ^
   mm/page_alloc.c:6951:27: error: use of undeclared identifier 'descriptor'
    6951 |         if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
         |                                  ^~~~~~~~~~
   4 errors generated.


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
