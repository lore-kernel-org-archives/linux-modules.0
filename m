Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09B1DFF0;
	Sun,  7 Sep 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757229450; cv=none; b=qGCE2vh3DhzMv+b5IZrOD3tHy8PnwM/o+atIyDBIWLzDCYrvISCb0kwrNtPEib8WQW5mZmqF54W1Ey/sWRMDP5M+3Y7liDgrbdRlotMU/4Yf5uQdS2hMV0ZiBmhLGGG1Ss8AZCr/NoYDS1jVDRVpMA+Nd5Lxo/JoX8N9aS4BXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757229450; c=relaxed/simple;
	bh=5QnvahDDoSfVPYd0OMon3YGK0VQvDxfku7S9GknZTYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un2NZ0rf0FM5Y58WwGkFTFHkt2BNJ96SM74zYYzt4lBUyg7ntBPSCjrfukZTxXTuyqr+pMHLd0TzkCzeEveeqvnhXYVjXqQRhiddS3ewOl9esJCRl39sFMzcuzQPtKduHPfcrhhCKpb+i2w5WkSjFtOqxRdpdmu8eUT+YrdJAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKfex2JT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKfex2JT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757229448; x=1788765448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5QnvahDDoSfVPYd0OMon3YGK0VQvDxfku7S9GknZTYI=;
  b=eKfex2JTC8GzfgAqyzhw9/SiCUePw+if9DLphghEkjYQFDaO1d1LEYht
   6O+byXWRAoJJzGH4QDJzkb0aSejZZw66brrN7eKHXks1WIovfV8HQwq5W
   wEFhpG9ZYGYWbyZ+f8Fcv7+AZ4/dFd+czjuMAtVj3FYDLaWqXv6mRS+TD
   NjYo1R0zZhr3t5IZEBEpPLncVJWadzklzFCO8/UkeEraFrH/2z8XCUWZe
   C4b+9DbSNiuEGZXdjOaEeDsjgGTb5t1PpV/pySLWdk8yFxgPnr5v9aK4f
   Nfgn1qQfnMuSEFH/aQ4q6kAyfTEj2kqvCv/FOmifkb41RNjOPWYQOQmT5
   A==;
X-CSE-ConnectionGUID: K4T6wwwjRPuQEipkXlm0sg==
X-CSE-MsgGUID: CzNra6//Rs2xP8EB7swo1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="58728333"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="58728333"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 00:17:28 -0700
X-CSE-ConnectionGUID: RLrd80R8RdKAe6wmMf5B1g==
X-CSE-MsgGUID: ziM7I9zISiKDJG6tht04Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="176860507"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2025 00:17:26 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv9eO-00026l-00;
	Sun, 07 Sep 2025 07:17:24 +0000
Date: Sun, 7 Sep 2025 15:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: Fidal Palamparambil <rootuserhere@gmail.com>,
	linux-modules@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mcgrof@kernel.org, petr.pavlu@suse.com,
	da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: Re: [PATCH] tracing: Fix multiple issues in trace_printk module
 handling
Message-ID: <202509071540.GTxwwstz-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fidal-Palamparambil/tracing-Fix-multiple-issues-in-trace_printk-module-handling/20250906-214415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250906134148.55-1-rootuserhere%40gmail.com
patch subject: [PATCH] tracing: Fix multiple issues in trace_printk module handling
config: powerpc-randconfig-r131-20250907 (https://download.01.org/0day-ci/archive/20250907/202509071540.GTxwwstz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250907/202509071540.GTxwwstz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509071540.GTxwwstz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_printk.c:388:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected struct dentry *dentry @@     got int @@
   kernel/trace/trace_printk.c:388:16: sparse:     expected struct dentry *dentry
   kernel/trace/trace_printk.c:388:16: sparse:     got int

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
