Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3E29B224;
	Sun,  7 Sep 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757270074; cv=none; b=O9ndoTFXlcSA8oQ29tz2ovUDsKv6A/kRMMI3kCwSGH7kZMOALfHYdFGsh4wS9bl9FRuZoPxLM1VA39/KqwCtPab4D3CWylnREw57chZiCry7vBCVeMcYL/U6821oZYmWwg/f5yCt+g+MfJwDIziPO8MkXIrVpGeV2yponIB8Is8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757270074; c=relaxed/simple;
	bh=37tgsekhRC7jsz5y0sdfR8LK3cgAZ+5Q6tUdBMysNJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggSmDSWzE4t4jHU51Mcu5bvj4YdHb0YLRTmvdGsr2jaXstjMIgN+aqp+Mq/EcCe1IoYbWIsBxTWKoL1B1f6el6njJP2i86imXGBljCy5hZAnB0I5QqlvrmtRpYKq41quvbNE3rnhBNkC61AhqjILO4K1lFYjcAoC7kWLA9NPAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0VzaZSh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0VzaZSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757270073; x=1788806073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37tgsekhRC7jsz5y0sdfR8LK3cgAZ+5Q6tUdBMysNJo=;
  b=L0VzaZShC2x31IOpuTPsd5Pfd+6K4i4LkJDsTBXGbDiZXXCa5KoH/FpX
   L6WOC24jvijzucFEkk3nXiKBwQWKL2jcdDvhvhF8qngPqSaCyQlETMEQf
   tqQdtNBCvYr5kOrCCdOYtU6GqyO7oLqtqsRVqJpbvZz88U7Z5oW0J40mC
   6zGpwokBct2+IB7efEMWjAlrYJp90Vbc2RxYR0M0hiUrl5eUHo+FwgbfO
   hDRm5rrnRbFk5pLN/FXY0GShkQz9jykSrpeR3oIJGoV+j0FABEirYtPFF
   qJLAyoVUskS5443XIaXniyi4CbfqmRwf1ZsAflVDULHO/hrcO79ar0Qj7
   A==;
X-CSE-ConnectionGUID: SlhFhpv/QwOBNaQJHY3Teg==
X-CSE-MsgGUID: tlRrca/GTJa4yI4IG9CqKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59610920"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="59610920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 11:34:33 -0700
X-CSE-ConnectionGUID: n9AuYTOgQ8eek0iHO+jCJg==
X-CSE-MsgGUID: BIDTGyqgQUyCMnji1ccjow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="203398514"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Sep 2025 11:34:30 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvKDb-0002Rj-0g;
	Sun, 07 Sep 2025 18:34:27 +0000
Date: Mon, 8 Sep 2025 02:33:43 +0800
From: kernel test robot <lkp@intel.com>
To: Fidal Palamparambil <rootuserhere@gmail.com>,
	linux-modules@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: Re: [PATCH] Fixed the build warning in
 init_trace_printk_function_export():
Message-ID: <202509080203.SxCdQOOY-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fidal-Palamparambil/Fixed-the-build-warning-in-init_trace_printk_function_export/20250907-221041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250907140755.529-1-rootuserhere%40gmail.com
patch subject: [PATCH] Fixed the build warning in init_trace_printk_function_export():
config: x86_64-buildonly-randconfig-002-20250907 (https://download.01.org/0day-ci/archive/20250908/202509080203.SxCdQOOY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250908/202509080203.SxCdQOOY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509080203.SxCdQOOY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_printk.c:369:18: error: passing 'const struct file *' to parameter of type 'struct file *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     369 |         return seq_open(file, &show_format_seq_ops);
         |                         ^~~~
   include/linux/seq_file.h:108:27: note: passing argument to parameter here
     108 | int seq_open(struct file *, const struct seq_operations *);
         |                           ^
>> kernel/trace/trace_printk.c:373:10: error: incompatible function pointer types initializing 'int (*)(struct inode *, struct file *)' with an expression of type 'int (struct inode *, const struct file *)' [-Wincompatible-function-pointer-types]
     373 |         .open = ftrace_formats_open,
         |                 ^~~~~~~~~~~~~~~~~~~
   2 errors generated.


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
7975a2be16dd42 Steven Rostedt          2009-03-12  372  static const struct file_operations ftrace_formats_fops = {
7975a2be16dd42 Steven Rostedt          2009-03-12 @373  	.open = ftrace_formats_open,
7975a2be16dd42 Steven Rostedt          2009-03-12  374  	.read = seq_read,
7975a2be16dd42 Steven Rostedt          2009-03-12  375  	.llseek = seq_lseek,
7975a2be16dd42 Steven Rostedt          2009-03-12  376  	.release = seq_release,
7975a2be16dd42 Steven Rostedt          2009-03-12  377  };
7975a2be16dd42 Steven Rostedt          2009-03-12  378  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
