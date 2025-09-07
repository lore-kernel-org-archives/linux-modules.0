Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18F19F137;
	Sun,  7 Sep 2025 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757218274; cv=none; b=QDzzD8YIpvzk7ZyslKdj/QOIpvvvt7Pu9bpr+YAvd0Iqrdn0KY3okxFhy3lIevujeP9RV+Pqd+L+xB+eQ4Dp16dabfJSk0ZenlvepATTZmzcCMeZmZYJPB5/JpvwRkGsxLBnNJ35Btgc6rYD7tdjdHxsL2jIoXRXxJ6W0iGYkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757218274; c=relaxed/simple;
	bh=cYxBcCmTOo12YM48X4mOWGXeVa3FDhnpj3RjPyEsh6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtrxOrk0Reek+WbSob/DsSw9G0vKCwwiqqDBwnYmhQJxz+SWV53ARzS18Np3bmu9TauV4L363N9lQMmMiTL/HcLQgTfo1+uFU31Kk3ib1L38Zeosvx+VixpAJ/UsgYsXyQQS+sVQkEXSQctRMEK/eeGLe4aKQiarZxnjCFZ58lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L40Cu04v; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L40Cu04v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757218273; x=1788754273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYxBcCmTOo12YM48X4mOWGXeVa3FDhnpj3RjPyEsh6I=;
  b=L40Cu04vNtVgQBPSlY7nKb+Cbt0C6pwFud1dbix3KRgH3xQDweYjPRHY
   Qm93lPOcloj0rOqHlKhrcejeDuyB+/k/+aJeE3eXnlpRLbWesVR9G1TJ4
   cJdc5j6dZjDTHpetNw8kscfE7GRlnX90yOt8IG4zLS8kWdPKtlyG0FV8+
   KSs1W0u1BWoBZz344QzEINtwepQBy07emDbdXwHYHfvTcI5Fvf4GETMcE
   Q2mTD/1twqtHV/UzlUFvx9XciMBKWtcfI84mxxOUhxXMBm937TbdOKi2n
   3UAz7owagKH/wInO8WHP1pxXvArN8gb/o/R9aaITJSD7fYx0mPevhHiI/
   A==;
X-CSE-ConnectionGUID: BbLxS/SMRD2QNI123X9qiQ==
X-CSE-MsgGUID: mGU82jZ9TFi8UVmF1AGoRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="63340709"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="63340709"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 21:11:12 -0700
X-CSE-ConnectionGUID: ty+8UhvVTLSJ0fsxVRy7xQ==
X-CSE-MsgGUID: UfJzP6pHS1Sx+e6eeJinZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="171761634"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Sep 2025 21:11:10 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv6k7-00021H-1s;
	Sun, 07 Sep 2025 04:11:07 +0000
Date: Sun, 7 Sep 2025 12:11:02 +0800
From: kernel test robot <lkp@intel.com>
To: Fidal Palamparambil <rootuserhere@gmail.com>,
	linux-modules@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mcgrof@kernel.org, petr.pavlu@suse.com,
	da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: Re: [PATCH] tracing: Fix multiple issues in trace_printk module
 handling
Message-ID: <202509071126.l4plN0Qk-lkp@intel.com>
References: <20250906134148.55-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906134148.55-1-rootuserhere@gmail.com>

Hi Fidal,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fidal-Palamparambil/tracing-Fix-multiple-issues-in-trace_printk-module-handling/20250906-214415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250906134148.55-1-rootuserhere%40gmail.com
patch subject: [PATCH] tracing: Fix multiple issues in trace_printk module handling
config: s390-randconfig-002-20250907 (https://download.01.org/0day-ci/archive/20250907/202509071126.l4plN0Qk-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509071126.l4plN0Qk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509071126.l4plN0Qk-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_printk.c: In function 'init_trace_printk_function_export':
>> kernel/trace/trace_printk.c:388:16: error: assignment to 'struct dentry *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     388 |         dentry = tracing_init_dentry();
         |                ^


vim +388 kernel/trace/trace_printk.c

   383	
   384	static __init int init_trace_printk_function_export(void)
   385	{
   386		struct dentry *dentry;
   387	
 > 388		dentry = tracing_init_dentry();
   389		if (IS_ERR(dentry))
   390			return 0;
   391	
   392		trace_create_file("printk_formats", TRACE_MODE_READ, NULL,
   393					    NULL, &ftrace_formats_fops);
   394	
   395		return 0;
   396	}
   397	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
