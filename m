Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2D280024;
	Wed, 26 Nov 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164502; cv=none; b=Sli0ID2+tyAJFaYISoWazWQWlB5wQUg7r1Hyfa+XACyWt8BgUQn71eqVG6JDSwSKaYH9FiDKDmimKWHPEq9cXDI5DIZJVkTXSAnwjMoLllKzAQq3/GCDIo7v7pKczbwE21KbeZCEPxkc4uISJlk8dkR0PX9VUp4BbKEkUH4bL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164502; c=relaxed/simple;
	bh=2028ThgkXy0dTdUmOIYKJXcHuEjAOpSXf9oPdrnhF4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCzocjoXj6lCYuDfTU/JKn2kU5DJTUAi+ohnxhA3CULkQ7GXgrK597X0YmeM7TJOGbV3RnHZm8LNJmYZYu91c7WIgA41h2v5yms3mGPL9nt279Bq7GYlfTVUFm7G7A5gvMdm4pG9lUeJFsnR6I1zE0FGDfsJLxbKTQr9kb95WgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g18HKZiS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g18HKZiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952D8C113D0;
	Wed, 26 Nov 2025 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764164502;
	bh=2028ThgkXy0dTdUmOIYKJXcHuEjAOpSXf9oPdrnhF4o=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g18HKZiSTM5+9hGF0NPES0cGtRkt/0XzZSS1lmKYeEifRzV6FwWMarHMGYZBD50IE
	 p8YSHjRqIKMQUgAmhHB6oqtFSXrq0avFWtvnVPUpOCvS6egcaXXh3Stiax0CfkHfuy
	 /FoBBr3jtb5uYO4Cn+P/M3QdNwE/f/xe4eKeSML7x3R5lhExkzTCAMFjWMz18e/M0t
	 tnn5S03CPg3JPtJ3xewvaxXck7EX0neUEoHSwe+v0b3YyYk8SilmSAOl+hSRTM9iRN
	 nndlbA8iUhlyp3sdkEmG/xIwrV3GdYOcvyXykp2dzFUtuFu3FYxhQshj797EXX/56K
	 p52hJ2KBEampw==
Message-ID: <84b74435-5aad-4c15-aea5-db87b4a6bf11@kernel.org>
Date: Wed, 26 Nov 2025 14:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [linux-next:master 4806/10599] error[E0560]: struct
 `bindings::kernel_param_ops` has no field named `get`
To: kernel test robot <lkp@intel.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Benno Lossin <lossin@kernel.org>, linux-modules@vger.kernel.org
References: <202511210858.uwVivgvn-lkp@intel.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <202511210858.uwVivgvn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/11/2025 01.24, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   88cbd8ac379cf5ce68b7efcfd4d1484a6871ee0b
> commit: 0b08fc292842a13aa496413b48c1efb83573b8c6 [4806/10599] rust: introduce module_param module
> config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/archive/20251121/202511210858.uwVivgvn-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511210858.uwVivgvn-lkp@intel.com/reproduce)

We can't reproduce this.

If anyone cares, please let us know how to reproduce it. 

Tested on Debian testing x86_64 host.

rustc --version
rustc 1.91.1 (ed61e7d7e 2025-11-07

/home/dagomez/0day/llvm-22.0.0-e19fa930ca838715028c00c234874d1db4f93154-20250918-184558-x86_64/bin/clang-22 --version
ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-project.git e19fa930ca838715028c00c234874d1db4f93154)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/dagomez/0day/llvm-22.0.0-e19fa930ca838715028c00c234874d1db4f93154-20250918-184558-x86_64/bin

  561  wget https://download.01.org/0day-ci/archive/20251121/202511210858.uwVivgvn-lkp@intel.com/config
  563  git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
  565  mkdir -p build_dir && cp config build_dir/.config

  571  COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-22 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=um olddefconfig
  572  COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-22 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=um prepare
  573  COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-22 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=um -j$(nproc)

I'm just getting these warnings:

...
In file included from ../arch/um/include/asm/io.h:24:
../include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
 1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
      |                                                   ~~~~~~~~~~ ^
In file included from ../drivers/gpu/drm/nouveau/nvc0_fence.c:24:
In file included from ../drivers/gpu/drm/nouveau/nouveau_drv.h:42:
In file included from ../drivers/gpu/drm/nouveau/include/nvif/client.h:5:
In file included from ../drivers/gpu/drm/nouveau/include/nvif/object.h:4:
In file included from ../drivers/gpu/drm/nouveau/include/nvif/os.h:8:
In file included from ../include/linux/pci.h:38:
In file included from ../include/linux/interrupt.h:11:
In file included from ../include/linux/hardirq.h:11:
In file included from ../arch/um/include/asm/hardirq.h:5:
In file included from ../include/asm-generic/hardirq.h:17:
In file included from ../include/linux/irq.h:20:
In file included from ../include/linux/io.h:12:
In file included from ../arch/um/include/asm/io.h:24:
../include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
 1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
      |                                                   ~~~~~~~~~~ ^
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
In file included from ../drivers/gpu/drm/nouveau/gv100_fence.c:5:
In file included from ../drivers/gpu/drm/nouveau/nouveau_drv.h:42:
In file included from ../drivers/gpu/drm/nouveau/include/nvif/client.h:5:
In file included from ../drivers/gpu/drm/nouveau/include/nvif/object.h:4:
In file included from ../drivers/gpu/drm/nouveau/include/nvif/os.h:8:
In file included from ../include/linux/pci.h:38:
In file included from ../include/linux/interrupt.h:11:
In file included from ../include/linux/hardirq.h:11:
In file included from ../arch/um/include/asm/hardirq.h:5:
In file included from ../include/asm-generic/hardirq.h:17:
In file included from ../include/linux/irq.h:20:
In file included from ../include/linux/io.h:12:
In file included from ../arch/um/include/asm/io.h:24:
../include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
 1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
      |                                                   ~~~~~~~~~~ ^
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
  AR      drivers/gpu/drm/nouveau/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
  CC      .vmlinux.export.o
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
/usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
  NM      .tmp_vmlinux1.syms
  KSYMS   .tmp_vmlinux1.kallsyms.S
  AS      .tmp_vmlinux1.kallsyms.o
  LD      .tmp_vmlinux2
/usr/bin/ld: warning: .tmp_vmlinux2 has a LOAD segment with RWX permissions
  NM      .tmp_vmlinux2.syms
  KSYMS   .tmp_vmlinux2.kallsyms.S
  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux.unstripped
/usr/bin/ld: warning: vmlinux.unstripped has a LOAD segment with RWX permissions
  NM      System.map
  OBJCOPY vmlinux
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  LINK linux
make[1]: Leaving directory '/home/dagomez/ws/c131/kernel/vcs/modules/build_dir'

> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511210858.uwVivgvn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `get`
>    --> rust/kernel/module_param.rs:166:13
>    |
>    166 |             get: None,
>    |             ^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    177 | make_param_ops!(PARAM_OPS_U32, u32);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `free`
>    --> rust/kernel/module_param.rs:167:13
>    |
>    167 |             free: None,
>    |             ^^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    177 | make_param_ops!(PARAM_OPS_U32, u32);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `flags`
>    --> rust/kernel/module_param.rs:164:13
>    |
>    164 |             flags: 0,
>    |             ^^^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    178 | make_param_ops!(PARAM_OPS_I64, i64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `set`
>    --> rust/kernel/module_param.rs:165:13
>    |
>    165 |             set: Some(set_param::<$ty>),
>    |             ^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    178 | make_param_ops!(PARAM_OPS_I64, i64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `get`
>    --> rust/kernel/module_param.rs:166:13
>    |
>    166 |             get: None,
>    |             ^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    178 | make_param_ops!(PARAM_OPS_I64, i64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `free`
>    --> rust/kernel/module_param.rs:167:13
>    |
>    167 |             free: None,
>    |             ^^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    178 | make_param_ops!(PARAM_OPS_I64, i64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `flags`
>    --> rust/kernel/module_param.rs:164:13
>    |
>    164 |             flags: 0,
>    |             ^^^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    179 | make_param_ops!(PARAM_OPS_U64, u64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `set`
>    --> rust/kernel/module_param.rs:165:13
>    |
>    165 |             set: Some(set_param::<$ty>),
>    |             ^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    179 | make_param_ops!(PARAM_OPS_U64, u64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `get`
>    --> rust/kernel/module_param.rs:166:13
>    |
>    166 |             get: None,
>    |             ^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    179 | make_param_ops!(PARAM_OPS_U64, u64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `free`
>    --> rust/kernel/module_param.rs:167:13
>    |
>    167 |             free: None,
>    |             ^^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    179 | make_param_ops!(PARAM_OPS_U64, u64);
>    | ----------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
>>> error[E0560]: struct `bindings::kernel_param_ops` has no field named `flags`
>    --> rust/kernel/module_param.rs:164:13
>    |
>    164 |             flags: 0,
>    |             ^^^^^ `bindings::kernel_param_ops` does not have this field
>    ...
>    180 | make_param_ops!(PARAM_OPS_ISIZE, isize);
>    | --------------------------------------- in this macro invocation
>    |
>    = note: all struct fields are already assigned
>    = note: this error originates in the macro `make_param_ops` (in Nightly builds, run with -Z macro-backtrace for more info)
> ..
> 
