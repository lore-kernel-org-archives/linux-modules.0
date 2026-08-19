Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BD4854ED
	for <linux-modules@vger.kernel.org>; Wed, 19 Aug 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155936; cv=none; b=bqaBqOgfbjEsulvpvn8AJGnLmdvpKn+rnSbsHBfOHX6s1WwmcrGi1feHUv7xAvgq3sZbQO/xVoUg/sAhzq2FavGPJDVbKs79UE9aVPeT5SFNtXqy3VH56JDVTQH6z7hK1S/k8Tm7lZuCWf5oPtsk0wB34F3TwpMlqkj/2pnRz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155936; c=relaxed/simple;
	bh=COTadqnOSWDFbgG1yt62RAwG6YkPqDIbHIq2wsQBM1c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=slcNgV7eQzBEdpNmoRj82ksOJuVPD42ge8c/WyZ67QvvDDiYDU6KWMyMfQ6FFQdgb7PbgGsCWzohrYecXR7uTMutgV1BBy0Hqoe8XIlLr21Iv9arVykrxiWibNkNR0YvKxgXVje2NxoV/hX1vEquvWDZzZrlEJ5/D/vEaHBXmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEhuL8s2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEhuL8s2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787155933; x=1818691933;
  h=date:from:to:cc:subject:message-id;
  bh=COTadqnOSWDFbgG1yt62RAwG6YkPqDIbHIq2wsQBM1c=;
  b=NEhuL8s2gKotlCiEEfAibjrjpkiWSe+0/2MIVE2w9ZkBSjGXa8hXV54y
   bGp204VX05JsrJ6qPIEAkkiAVt6nL8a9Rp+LghpuAr+ELOziGLSwE3lZL
   ggNL2f6zQq1grFZpsMjYsNXnYVx/sraxYLg9K5pj7U+APcR9xgS+Vcp+n
   N4rJ8Zt5cskZKD45lD3UWV4gms/oI6FkMChuuKoZQQ3YjgJdg3FoRbV0d
   SoGB73hT/hWpotUgvud3yR6OS+t9u0qoOE0IncHFSZ3AB1i4TmG565oYz
   nYE1GXNK4c6P9ohKqIGBx3mP+DwYqPEuqSamiyG1DGMMehy//uyzZClZZ
   w==;
X-CSE-ConnectionGUID: VDaztFM1RhWHuoA3yU/45w==
X-CSE-MsgGUID: q/sccDzhSWujIKLPk++SPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105062822"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105062822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:12:12 -0700
X-CSE-ConnectionGUID: xCbnZ+GSSKCVTkSVjcfr3A==
X-CSE-MsgGUID: iCaWcmHeS0ecvad9fPp1mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="262336475"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2026 09:12:10 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwitc-000000007Nd-0cJe;
	Wed, 19 Aug 2026 16:12:08 +0000
Date: Wed, 19 Aug 2026 18:11:37 +0200
From: kernel test robot <lkp@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org
Subject: [modules:ppavlu-module-include 35/37] error[E0609]: no field
 `__bindgen_anon_1` on type `bindings::kernel_param`
Message-ID: <202608191847.ew1wQKaQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git ppavlu-module-include
head:   fcbfd3cbe0a054838436812cc0b664f71ba1d0a4
commit: 2021aa3988f7a166b2be26c84d10fc6d1cc3d913 [35/37] module: Move module information macros into their own header
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260819/202608191847.ew1wQKaQ-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260819/202608191847.ew1wQKaQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608191847.ew1wQKaQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0609]: no field `__bindgen_anon_1` on type `bindings::kernel_param`
   --> rust/kernel/module_param.rs:78:46
   |
   78 |         let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
   |                                              ^^^^^^^^^^^^^^^^ unknown field
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `flags`
   --> rust/kernel/module_param.rs:164:13
   |
   164 |             flags: 0,
   |             ^^^^^ `bindings::kernel_param_ops` does not have this field
   ...
   172 | make_param_ops!(PARAM_OPS_I8, i8);
   | --------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `set`
   --> rust/kernel/module_param.rs:165:13
   |
   165 |             set: Some(set_param::<$ty>),
   |             ^^^ `bindings::kernel_param_ops` does not have this field
   ...
   174 | make_param_ops!(PARAM_OPS_I16, i16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `get`
   --> rust/kernel/module_param.rs:166:13
   |
   166 |             get: None,
   |             ^^^ `bindings::kernel_param_ops` does not have this field
   ...
   174 | make_param_ops!(PARAM_OPS_I16, i16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `free`
   --> rust/kernel/module_param.rs:167:13
   |
   167 |             free: None,
   |             ^^^^ `bindings::kernel_param_ops` does not have this field
   ...
   174 | make_param_ops!(PARAM_OPS_I16, i16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `flags`
   --> rust/kernel/module_param.rs:164:13
   |
   164 |             flags: 0,
   |             ^^^^^ `bindings::kernel_param_ops` does not have this field
   ...
   175 | make_param_ops!(PARAM_OPS_U16, u16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `set`
   --> rust/kernel/module_param.rs:165:13
   |
   165 |             set: Some(set_param::<$ty>),
   |             ^^^ `bindings::kernel_param_ops` does not have this field
   ...
   175 | make_param_ops!(PARAM_OPS_U16, u16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `get`
   --> rust/kernel/module_param.rs:166:13
   |
   166 |             get: None,
   |             ^^^ `bindings::kernel_param_ops` does not have this field
   ...
   175 | make_param_ops!(PARAM_OPS_U16, u16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `free`
   --> rust/kernel/module_param.rs:167:13
   |
   167 |             free: None,
   |             ^^^^ `bindings::kernel_param_ops` does not have this field
   ...
   175 | make_param_ops!(PARAM_OPS_U16, u16);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `flags`
   --> rust/kernel/module_param.rs:164:13
   |
   164 |             flags: 0,
   |             ^^^^^ `bindings::kernel_param_ops` does not have this field
   ...
   176 | make_param_ops!(PARAM_OPS_I32, i32);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `set`
   --> rust/kernel/module_param.rs:165:13
   |
   165 |             set: Some(set_param::<$ty>),
   |             ^^^ `bindings::kernel_param_ops` does not have this field
   ...
   176 | make_param_ops!(PARAM_OPS_I32, i32);
   | ----------------------------------- in this macro invocation
   |
   = note: all struct fields are already assigned
   = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
..

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
