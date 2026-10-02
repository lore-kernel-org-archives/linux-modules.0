Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D5489FC2
	for <linux-modules@vger.kernel.org>; Fri,  2 Oct 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941726; cv=none; b=o5xMQJRAg74ReKT8dKt4gllS6WiD3GwrlUMpBlXNOyc7SSN9yClnMMN6UDqjO1e4wmPE4l9Au8pkgHgHzznxFtlW668/A/wPK4P+TU0mLWpx9ELyrwYnrlg7DZFvIPyyYPClIwV52ZyRlA4NMTKPxzUj8KC8WB7b0iIcn/kWtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941726; c=relaxed/simple;
	bh=gAY+ry7XQppx5kZcg+BfzcVwDqxF38v68qrWhv2EpEU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=tQA3fEyr+hko+IG3QMNoUdeni3G6oeKl6CU15R0TsBdqO7jV4lM2foPyZPRBTgHsIp+XP9Emt6JB60PPgX5iuj2auXGFl3u0HRQzmYmjCqgPmgYOJjHDaq73IQ91ZucjlPaN+oTbMhSSJFvymKsxYQRwIG8REOfbbkZk8t6DWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeyZIhmU; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeyZIhmU"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso4898900a12.3
        for <linux-modules@vger.kernel.org>; Fri, 02 Oct 2026 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790941724; x=1791546524; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDgCZ93FbbC+h+9QAZpC0c3CaTDV4NHqwfDJ+8l3w7I=;
        b=MeyZIhmU8tcw6SYtV+1UZ7tSerG+sxuHQGu95Sf+jXbAr1jEANi1Xr2UvlE2O8dFCC
         Kz4XzfQuSc3KIwWpsVO1Wp9OmjeYf+k2zVFqFV8MrniXv/Iv8UCfKoVfgmpUA3BuiRNo
         E09LSomNq7IqB2WCn+1NYu8sFOkvU0Cu6beoCzkTV3AHfDKdEtalVaFOtKnZkVt+FvBt
         TdkVI6itaXRa85ogpErUJnSIghBnEdXTd3G62zvw8C3M2iygDKn2y0J1J0hsAnGP9hT8
         3SVS+eFmQ2NIyY/3qTsvtmqitlyjb/IelUbO2q1DHTFsAfgRgFm+mHLNtvYT7EJfslZ4
         pFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941724; x=1791546524;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDgCZ93FbbC+h+9QAZpC0c3CaTDV4NHqwfDJ+8l3w7I=;
        b=Qc9evG5Yw2Etd1m/riDBuIPD1egLCzm/+/MdfxIFHxq4BkVjjYMrEkjGzZ8oO9puKx
         R16m1GQCK214nBBk/9XTgAqPpQqY+d7acViUHV2JXEaHfmPhMxYH5+L21QgrefIzs9TH
         fGhfRr+kcCx9KaeVETc3QFMCKvDjbNhJThkNO8ngUrEJIK9uVD8HzQ8Kp8veA9ULoOzW
         HHEY4kCuj3QJsTyWOqcjAMXnlJWgHvpXDo1uhNyMQb/QeYcp7sIu/jplPHLkyFEQnhTG
         HL22g1FYN56L5MG9tG9z+I3MDD71AeBe2go28gSLWexIYyWtddVHP/8NPr+9OCS+spm2
         K3mA==
X-Forwarded-Encrypted: i=1; AKwUvByT9aozpn0nHIkgDW0NP1vQJqd3nViJQ0qTIvwXw8OjZMIDTWSEeMBqm/LhPFbuKC2uNdVczminZIXVQHzD@vger.kernel.org
X-Gm-Message-State: AFuF++lnxc5QAms59IxxKUcqAG7wM7xBBT8k6MUNF+07RovDQQrcVwAB
	KFMwsOPSpbqxCNQU+czoOCQtd1rKFbbquNumhAKOI+BaNyTtHL0kgZAZ
X-Gm-Gg: AYBFou0GkR2gmjSsZ+RDTepu4TvnlDDPW7l1eVG8o8/lsLrkQL10q0D0FUg5dd1xCC6
	jrrmIySbtXwqgDhBce5CHT4VUywEC3Gk1VO+hM7YS1Szo9buinMdIoPHZ1Fz2VviFe4C5dnQdgb
	G0dxhIHaCIJrlWNo1fSC9GNIrxBqcM6k+Aob33wkM1Q4dMCDc7ZVEU2G1x/M/+KQOqFSNEWCFn6
	QUgKkLedrsfiusGLWJiNzjjvI6/rvdQ4K85mampkY2DdTLy33VzYzOpEJmvoHN3h74RI1JQqNCV
	XlubjEObI+gI2xio/1GdfMRserJKKyH16vwTRVzC7/8Qpz6LWna/U7Ercceqyia56MVB7sdRcA7
	SmayNAWITb4KXcP9w97IrLDKIQCXB9z1n/poNg7YmnCVeXyO+Q4/KPCwfJED5bWSqVN1T74ASpb
	TUAN8BVqipTzct7TxBs0nHQ+iKpgvIx3+5Xc//Kjpku/Y5Qn+lxlhfLceb6q1nFSOOLm46jh4y4
	Y/hJvtuzw6O2p8t+ow5davC0M42G8aXRSOlqW1YEmtUQs/bFzczC4qDmWXMAI0sUmaAd/7LMk4y
	s/s=
X-Received: by 2002:a05:6300:210a:b0:3e0:b937:8844 with SMTP id adf61e73a8af0-3e0bd199342mr2548048637.44.1790941723843;
        Fri, 02 Oct 2026 04:48:43 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247dbcsm743396b3a.55.2026.10.02.04.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:48:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:48:42 +0000
Message-Id: <DLUBUT40BBOG.1L6QS7A8CIE79@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Quentin Monnet" <qmo@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Christian
 Heusel" <christian@heusel.eu>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Sami Tolvanen"
 <samitolvanen@google.com>, <linux-modules@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ian Rogers"
 <irogers@google.com>, <linux-perf-users@vger.kernel.org>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <linux-input@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Hazem Mohamed Abuelfotoh"
 <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>, "Martin Pohlack"
 <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: take the vmlinux BTF from the
 btf_vmlinux module
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261001225214.12351-5-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com> <20261001225214.12351-5-wanjay@amazon.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 10:52 PM Jay Wang <wanjay@amazon.com> wrote:
> +	err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && err < 0 && bpf_btf_vmlinux_retry(cmd, misses))
> +		err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common),
> +				size_common);

Running the command twice when it failed and a global counter moved
is not going to fly.
Missing BTF is not always an error.
With =m and BTF not loaded yet take
  int prog(struct xdp_md *ctx)
with func_info. That is everything libbpf loads.
do_check_common() calls btf_prepare_func_args(env, 0).
find_canonical_prog_ctx_type() returns NULL, btf_is_prog_ctx_type()
returns false, the arg becomes ARG_PTR_TO_MEM and
func_info_aux[0].unreliable is set.
The prog loads. err == 0. No retry.
From then on freplace of that prog fails with
"Cannot replace static functions" and fentry/fexit see its args
as scalars, even after BTF is loaded.
With =y both work.

That is the only reason why "a socket filter does not load it".
In v3 such prog loaded BTF.
systemd built with BPF_FRAMEWORK loads
  int sd_bind4(struct bpf_sock_addr *ctx)
from manager_setup_cgroup() at every boot.

The result of the verification cannot depend on who touched BTF first.

bpf-ci is right too. The first run writes into uattr.

It's starting to feel that this is dead end.
So much complexity to save few Mbyte.

pw-bot: cr
