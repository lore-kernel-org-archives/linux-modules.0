Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F61922FD;
	Sun,  7 Sep 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757264486; cv=none; b=BXHgxuV5Ns6HpEMWmpKtJAPRZfgplrCD7lG6XoRG/9f82irzNvvTpU9nXWk523m3w8IjjNDQqpcFNvWOXRKCL4I1w6k/dNdF7Mr+Ki8RL9BFWvym7fgZl77nlZABs7Ru4d+1taGdrM7SSAQBTu0dhdd205yXFQT6bsXy8LqGzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757264486; c=relaxed/simple;
	bh=8Tm67jQQNXssHHVpk6mASydvBl2DcirB7AvwFZ5Cqd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR4ZsTvWAIG45EnKdYhXEnYBwDPCnLqnoPu1AUkaESqd5aZKaP9Ut54v1xz5yDT8ejcITlPlhcKVcmfhmIb2hI/w2RaCCDK2giZ9oiv5ghl1NKVL/nwv/H+GKk54a+TYPMXSDZHVJ1DZ/gVDJtzY93o3rk5tA0UKV+4wJPVzBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PN6SL+hH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN6SL+hH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757264484; x=1788800484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Tm67jQQNXssHHVpk6mASydvBl2DcirB7AvwFZ5Cqd0=;
  b=PN6SL+hHbGKaAhE5JdpEYPNHnjrdUmpsAZR9LTkrYGwEpERyvE0Yd7ua
   zdqoWThgraYGRKSB66+DYzl2X9tTRFBrUKdp20NK7miMbHvePPx6nD2PJ
   0InZnPPNcVq1HE5MUwiYzxEri+kEFGFhQpZGFFx/C3RWs7ad8PRlLUy3V
   1Ah9LjpjLKzfow3f2b+7pbtizmRoMB/Y2kgnkyicbK/GNvCt62OFoOlf/
   3D2gLgm8hNl0rhmMilpR5uujC23oLuoNEv74AIofaUiPJBE+0gsVmVsAm
   v9v7JErm76HKr/r0vm92Zcv04TsPddS8N7KlfmQbIXdPCib4euc8SrhHP
   A==;
X-CSE-ConnectionGUID: F1hhgKNqTpOOM00m5GAujA==
X-CSE-MsgGUID: n5ZdNBI2Q+6qCzBAfSIqTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63363928"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63363928"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 10:01:23 -0700
X-CSE-ConnectionGUID: sUfy7hRQSG2UMFOQfacacQ==
X-CSE-MsgGUID: JO3hPCyXSDaIWCW/22Ip7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="172523448"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Sep 2025 10:01:20 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvIlS-0002P5-1H;
	Sun, 07 Sep 2025 17:01:18 +0000
Date: Mon, 8 Sep 2025 01:01:05 +0800
From: kernel test robot <lkp@intel.com>
To: Fidal Palamparambil <rootuserhere@gmail.com>,
	linux-modules@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mcgrof@kernel.org, petr.pavlu@suse.com,
	da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: Re: [PATCH] Fixed the build warning in
 init_trace_printk_function_export():
Message-ID: <202509080040.8gEyq9Ef-lkp@intel.com>
References: <20250907140755.529-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907140755.529-1-rootuserhere@gmail.com>

Hi Fidal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fidal-Palamparambil/Fixed-the-build-warning-in-init_trace_printk_function_export/20250907-221041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250907140755.529-1-rootuserhere%40gmail.com
patch subject: [PATCH] Fixed the build warning in init_trace_printk_function_export():
config: x86_64-buildonly-randconfig-001-20250907 (https://download.01.org/0day-ci/archive/20250908/202509080040.8gEyq9Ef-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250908/202509080040.8gEyq9Ef-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509080040.8gEyq9Ef-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_printk.c: In function 'ftrace_formats_open':
>> kernel/trace/trace_printk.c:369:25: warning: passing argument 1 of 'seq_open' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     369 |         return seq_open(file, &show_format_seq_ops);
         |                         ^~~~
   In file included from kernel/trace/trace_printk.c:8:
   include/linux/seq_file.h:108:14: note: expected 'struct file *' but argument is of type 'const struct file *'
     108 | int seq_open(struct file *, const struct seq_operations *);
         |              ^~~~~~~~~~~~~
   kernel/trace/trace_printk.c: At top level:
   kernel/trace/trace_printk.c:373:17: error: initialization of 'int (*)(struct inode *, struct file *)' from incompatible pointer type 'int (*)(struct inode *, const struct file *)' [-Werror=incompatible-pointer-types]
     373 |         .open = ftrace_formats_open,
         |                 ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_printk.c:373:17: note: (near initialization for 'ftrace_formats_fops.open')
   cc1: some warnings being treated as errors


vim +369 kernel/trace/trace_printk.c

7975a2be16dd42 Steven Rostedt          2009-03-12  359  
7975a2be16dd42 Steven Rostedt          2009-03-12  360  static int
66670b02cb828c Fidal palamparambil     2025-09-07  361  ftrace_formats_open(struct inode *inode, const struct file *file)
7975a2be16dd42 Steven Rostedt          2009-03-12  362  {
17911ff38aa58d Steven Rostedt (VMware  2019-10-11  363) 	int ret;
17911ff38aa58d Steven Rostedt (VMware  2019-10-11  364) 
17911ff38aa58d Steven Rostedt (VMware  2019-10-11  365) 	ret = security_locked_down(LOCKDOWN_TRACEFS);
17911ff38aa58d Steven Rostedt (VMware  2019-10-11  366) 	if (ret)
17911ff38aa58d Steven Rostedt (VMware  2019-10-11  367) 		return ret;
17911ff38aa58d Steven Rostedt (VMware  2019-10-11  368) 
c8961ec6da22ea Li Zefan                2009-06-24 @369  	return seq_open(file, &show_format_seq_ops);
7975a2be16dd42 Steven Rostedt          2009-03-12  370  }
7975a2be16dd42 Steven Rostedt          2009-03-12  371  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
