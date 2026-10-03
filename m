Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9B421251
	for <linux-modules@vger.kernel.org>; Sat,  3 Oct 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791029951; cv=none; b=ut1lDWRO4r4stsGg+LN3A4nNkadeW8HPq8K7N5dRlS/H5G3osEnmEM+ZAMIK/h565CMqEHBBxqUrtnM8s2r2gqktwlXu9n/2H+/uwnWpNowGDuCVf2r0g1wPOfW9eu6ehvXFx69s1kWUg0jAqZA5BKAczImY0pT1PjFCxBWCOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791029951; c=relaxed/simple;
	bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=JpokhR9bod56aSNpErZN2sEnmKdRxMfllgC50dtjQe/fSkYE13QTNiq4Ybhc7fmp5pSK2/1kLmq+YH239m25uasM+CQ0oLNYeL5exph/3FaenRa6s4xfXV71Uzffd2KR23mzgIMBUdxu4slEA0F/ce84XnsxBaVdE63IzHlBuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya1uPvVe; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya1uPvVe"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc89e37f17aso157593a12.1
        for <linux-modules@vger.kernel.org>; Sat, 03 Oct 2026 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791029944; x=1791634744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=Ya1uPvVeeM6n17IR0e8tR+Fjn4A7Tt8xHAj2K4RCLwhM/hfRH2CLdq5KVXsqQ+7+x3
         Bjh71FLm+eHABWYeuAqtB8u41rC6u3Gv0BBngTOtNGGVVoYenWZdoIx3EaA3DW/NqxEm
         r1BZUyVLORTMFFEYNnrQzZPkAX5SzAzBvz9lKEZ3dm47fm7OGnnuU6Pf8eBH/fTDejMv
         npC3Z2mnofQdhE53ZvxxScLXy/4abR1ig/Pap4sIskWXMbYdPYLxYYrtmb8UwcnIJNTw
         789AGnYTn0CFfvhsFtKtHWJVNh1VUA9JUAmfn7mEfHa9u0CqKMUz5YKq5/iDP7QXZpvj
         C1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791029944; x=1791634744;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=TwkgKxFy0wubkGPtf2lu/TlMFu94iBND3jzUxA2nWyDY84VVQJrorQpGyL2nRAluFX
         aAr2XedRmJRdJO9meYi/U3998C417ftrI+WCVTthHnseWJQpCQhYz2Tn67Oawh5HLQ9m
         pk1Y9FtJrvTk+jxDTsbZksP2tPn4eWwsLyhuJpoeVvGBc/V+TpiudPIDmYVnuUPidyXV
         SZ3t5bViKtOQCyvfLvOrniRkHmeOFaT9DEefIQVnc3Fyp/hkb88fsHVMTVuP9pWSIEzQ
         +IhGXiflQz4O5j2fo4p5flVh3fvLvVnkdqOmpydtuvHDYnE1yzRBIg//nFSeY30kHJXa
         487A==
X-Forwarded-Encrypted: i=1; AKwUvBxi1MB2KEoEvbM7Dxd8MpuMcsiVFckPzT0d8aH17ZB8w0/P5n9CGetNM55/q8QctfLURBTIafIauLhnw0jL@vger.kernel.org
X-Gm-Message-State: AFuF++m8pP4ihnIE9flzKMPR5UoyKWDR1357mgfR2zZuIKZY+mQXBkNZ
	lyLOo6upIqmhtlKrAhbqzSTQTsoK8eXo1E391M+/359CJXohKGJLnqWc
X-Gm-Gg: AYBFou1WGsKR6wYSlO0GAW/qq32KHD4M+Z8cGvFirSug5TOI7K7HAqzhEtZMQF1Lpqk
	BeX3ya2SnFne1owQinkO2PyKTsxj7Xa7u/kUsiEINoggDIkNgJCuZ9XE0FBsmlbclFhJiXLrXwS
	xPp5l5TLJYdzfyKgyv+G4QagrayXwQbBkmaT+8p6Dl6utmc1FhjVsOAur+oYdGkm5qezfBqau5n
	BNjafgU3Z98Y35Fcdx7pcpUqLd5R01kcbS/0Dnl2scC/IBEHoJ1UQV5hv/bBpKl92rvyE5HuP0/
	XcMOE3mFf5IvydBqHPopMkHiyPAWnXbXkIi/wm4Ktj/rX0pyDhJ4fmPaC3RbFxuK9sx8sjV530D
	UIEwYcDlyUJPeLHxVFTRi8wE1yiWl4bb5pDHgc5AY4nMs2DZZyuMbrVcJAJO2x+WI0ITLMrMbOV
	Q6FP3/XQxjUuXYUr1HQsc4YH0cpG1P3rjsKs0OQpwiwPKWik3cnJBzbRTYmEPkvq1ad2e9BFeVB
	sYrkW4ZBb+EtozjZ/5TybBWBqErAFXcPs+y45gOlWPSWApTyjPD7blcqtIROXo9pevAv/ayP9Ap
	lJw=
X-Received: by 2002:a05:6a21:d89:b0:3dd:a197:7360 with SMTP id adf61e73a8af0-3e0d6d8ff80mr2052536637.57.1791029943830;
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cca561e9d1dsm1740373a12.6.2026.10.03.05.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:19:02 +0000
Message-Id: <DLV74KRI1SBL.MYZVQAB3N6QG@gmail.com>
Cc: <abuehaze@amazon.com>, <acme@kernel.org>, <andrii@kernel.org>,
 <arighi@nvidia.com>, <arnd@arndb.de>, <bentiss@kernel.org>,
 <bpf@vger.kernel.org>, <changwoo@igalia.com>, <christian@heusel.eu>,
 <daniel@iogearbox.net>, <doebel@amazon.de>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <irogers@google.com>,
 <jay.wang.upstream@gmail.com>, <jikos@kernel.org>, <jolsa@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux@weissschuh.net>, <martin.lau@linux.dev>,
 <mathieu.desnoyers@efficios.com>, <mcgrof@kernel.org>, <memxor@gmail.com>,
 <mhiramat@kernel.org>, <mpohlack@amazon.de>, <namhyung@kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <ojeda@kernel.org>,
 <petr.pavlu@suse.com>, <qmo@kernel.org>, <rostedt@goodmis.org>,
 <rust-for-linux@vger.kernel.org>, <samitolvanen@google.com>,
 <sched-ext@lists.linux.dev>, <shuah@kernel.org>, <tj@kernel.org>,
 <void@manifault.com>, <wanjay@amazon.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an
 on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>
In-Reply-To: <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
References: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com> <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 03, 2026 at 12:45 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> The only overall cost is if when we wind up using vmlinux BTF with the compressed
> .BTF section, since we have to do a full vmlinux BTF allocation (on top of the
> spac taken up by the compressed .BTF section) right? So slight penalty if vmlinux
> is used, but big gain if not.

I think it can be copied compressed into vmalloc area and
freed after decompress, so memory usage should be exactly the same.
