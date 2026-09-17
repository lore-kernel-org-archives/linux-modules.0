Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6451814A
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667004; cv=none; b=pLjLdiP6Qk2+XNuR7/34mUryM4E4u+ozM7oGgGr5NisL9oFVwtCBluh0oKJyf2f4mQ30nxJpJZNJcfItRDUD4nc766wAnXmTppXbSyWYLk0bjq8X6cuDoDWjeNNVCvirZqaSI+fqApjDXaaO1tOTPU8M06awgx30b513GtJN6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667004; c=relaxed/simple;
	bh=444jU8uxONFDfWRTdInIMtXV5eo1AbdDgMSf0Q+N+2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fp2CMuHjPzbcnilV2SbT0iy2QbQ8of2NIl3tjzi9gfmVNQCDzl47V4nqchPNWI/8vefPQv4IzIiOC1vcf0o45A2P/ZIoL7DzIRf87lX2nWYrkRtu2oGh3SenqKimi6QNm1l3tomEka+74bfD1EJgrk+OFIxjB4P7SxIlzrA9wUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=I2TP1KkU; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="I2TP1KkU"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso978381a12.0
        for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1789667002; x=1790271802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5eExaHbJZnwQdAGroZ7wxeNna2+m+5wmicEcqAFsiQ=;
        b=I2TP1KkUaEkPqnFuU+N/gVG0S5Xtco+Fu2eiHIkAm4mfRZ0mVfdcqUDHhCBrhC4uAF
         N4d7pqh0phcqHIVJdm6wcdSbb6hfens1BlJQ5ResM7k6kgt+6Cjh/sJ67hJWl2tpwLYL
         Ku3WRWEHvdKRgtfFD5KwRaq+u9+PkmGIDny05fkkaAL4Zlktiz3Tbqc2q425VfEKWpj+
         webQL9eyPY351F+foQhEF+FWl5mD4O9wOED5WqCLhfLLUrMG1JCGF/D6dko7fHlYfaOw
         nb4qKSAb1MjMPgCYQpmJn37M8Vp79N8gtjAcxwClxRaOY/JSrUBc86CVa9vwRX6XbDSt
         QnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667002; x=1790271802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5eExaHbJZnwQdAGroZ7wxeNna2+m+5wmicEcqAFsiQ=;
        b=AETPbPAsHmZaDr0KNigq/5sCL7VpICY8DjVcMFwR0VtK48eYqCJA/iNdoAjtHa91Ko
         yMCmu1tUtVVTV8+pUxMdSWSDu8+gGibmevIYWoUXRk+x9Uq0J5lzhYAHoPVvMFqBHghX
         zz16ovFfI3GcvCmLwA/ElhD5HHRVCmasIdN9jjK7uFqlo6W6rlrU+wP8YNajb2oHNf23
         ZObICbPdTfuOz3rbuFa+ydxQmZ8vcLOsxIR89Uvi2sGkT1oe0D+kf+ZsQDoSGnVwBLD4
         OVD+eWc+6thI2wK8syALafpebjcMSVFyM3hDal3Uvl3wFtUEfYgm5qPzTVJSqvl/ZiNZ
         Y4qA==
X-Forwarded-Encrypted: i=1; AKwUvBzEEgVeNbKzWzu4tHDJbWhum6vplJPdzfXimOxWPS5jut8GYXFGJ6rQqE28eXjeE13b9w2tQUElZ0ycFw5x@vger.kernel.org
X-Gm-Message-State: AFuF++lSv+gKfTLKQy3gv9jdmG0bNcRhGUy08ld6heITntakfHiqD7NQ
	T84TZvXs0V0RpMeZ0iIY20hazDnWLfcXIYuo5VPCZvzz6qxjtcuD1RhhupSBjEX9bgs=
X-Gm-Gg: AYBFou2o2JhiABbG74r1Tkm2g1XAs5Q1DmfjbPLHBXXtG8/NQUgV+ULMz36C/+SnD3K
	ViVkTx3rJRwXfCnPStZGSlF/CQVU2Y7T48NVTN5qG7nzFZOPW0QxXfLulDjhT/Gq5QmjCYkywVf
	l64xihORkGsUnYD9yy/wxWjZD7fkzOha+aTcv8fSf9Nk0PEv0G7FZvVRRlfsEI7puZT78ePDvsy
	70yd2tvlv6Yeg3InTI4RQHTDOFzGmxWa9+oKW9BqUmbHdNSj/k9gZYt8FYfQbsgIc809r0zvGuU
	i4NTbHoMaKQETVLldBNzUA2+eWB3UBAfUqUJALbr5JILl1LxMDOgFFqL3y23D1ntfazFWYWLDck
	GMp87QqlyD/CChNCH36JbLgID2POxuk+weF5oG0MwgO0zoKK4wiZ7/Bvs2sEGhPuZaqIXSwPftP
	W2DLcW1JtGCTjyM0aL52AzgrvZCTHkTbU8PQHbv7f5FV8Im6uDosVIimx7B2pyUPoYoAL3lN+HZ
	KMh48yDdTn7wSpc/k1e86xRHIOt7ER1PN/5
X-Received: by 2002:a05:6a20:9147:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3dd5f57c1bamr17309358637.18.1789667002542;
        Thu, 17 Sep 2026 10:43:22 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm19657730eec.14.2026.09.17.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:43:22 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	ojeda@kernel.org
Cc: atomlin@atomlin.com,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 0/1] rust: module_param: Fix potentially incorrect access  of `SetOnce<T>`
Date: Thu, 17 Sep 2026 17:43:19 +0000
Message-Id: <cover.1789426258.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux kernel maintainers,

We are developing a tool called FerroLens to detect potential 
unsound behavior in Rust code in the Linux kernel. The tool 
internally uses an LLM to detect bugs.
We then perform manual analysis to verify these reports. 
FerroLens reported the following bug in rust/kernel/module_param.rs:

The `set_param` function casts `kernel_param.arg` to `*const SetOnce<T>`
But the Rust module macro in rust/macros/module.rs initializes `arg` with 
`#param_name.as_void_ptr()`, and `#param_name` is a `ModuleParamAccess<T>`,
not a `SetOnce<T>`.

ModuleParamAccess<T> has default Rust layout but `set_param` accesses its 
first field SetOnce<T> assuming it to be at offset 0. This is not 
guaranteed by Rust and if SetOnce<T> is not at offset 0 it could cause 
type confusion leading to data corruption.

In particular, if the kernel is built with a randomized layout 
(e.g with KRUSTFLAGS='-Zrandomize-layout=yes -Zlayout-seed=1'), 
the first field of `ModuleParamAccess<T>` may not be at offset 0. 
This leads to incorrect behavior when loading the rust_minimal module 
from samples.

$ sudo insmod samples/rust/rust_minimal.ko test_parameter=1 test_bool_parameter=false
insmod: ERROR: could not insert module samples/rust/rust_minimal.ko: File exists

[  854.638251] rust_minimal: `1' invalid for parameter `test_parameter'

Priya Bala Govindasamy (1):
  rust: module_param: Fix potentially incorrect layout for 
    `ModuleParamAccess<T>`

 rust/kernel/module_param.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

