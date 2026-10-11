Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026510F2
	for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728996; cv=none; b=FOWLpxJEIlQSxTkA0Cywfb5uKnH5tFTodrt2rGJAVo0Zcbwt45TA6jl0WchXOJSsQuLlbf6Crr0xJJTADimqSSLZd9qLR/onTXXxvv3vtjgRfR4ISYn3Sc1hKVFiQtEIIizSowKMG6Rl3oH1gbnSrNvjqhZnyKjghcEUJK9BxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728996; c=relaxed/simple;
	bh=lHZ4J0AAeMNX/nJymjWhRsTfWDaAs7AW8vIoxrjNByE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=USya6D14+aazCayG6SfW3ZfB41nP9AAkslJVGo/5hdSW5pQizdowvVsUmp+pjLGKU98aY633FbYhm7kxpJkvxvDSdXJTqyEnhNmCXxf3OJGiTyMP8KHUkcbbEbeAtBmDrjywzrUYZN8TE/TAK3PDuZwaXP8+ZtlSWU9+GzDDceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMb9c7XQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMb9c7XQ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso763716a91.3
        for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791728995; x=1792333795; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=spNkyy0SDHZKmf7Xc6j19NdGyS2zYykBSQlRjeJAYNE=;
        b=NMb9c7XQvT5kXdS0FHaNsOpQF9JUa24el0lDSwtpsoDC6Kv4CyDTfF/DRMztBgL6Jz
         f8Up+Yqs8ZDWT7FVUUZZXNYmNKJ9bedBkMQvWRuNlrjMeMQWG5VhDyDUAwGyg+6deSZ7
         DUVq8WbgIRYE5YNwcsFvjO/FUIFv59u+ZX31E2zJg89RoUjsWhHIB/PFCfPN66pDLKWl
         O1mr1I0RU0k3Pigdo8Nm0ePlnfHva17GjITfARj0sRmS2jYn630rmJ1bwom0T1vMM+IZ
         PHdALtC6C4MKSvt8Q3rTqWVaPkd3hUgjK2+x21TjyGstAk/odIN1hr4jVmWtLH75vHv3
         Nprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728995; x=1792333795;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=spNkyy0SDHZKmf7Xc6j19NdGyS2zYykBSQlRjeJAYNE=;
        b=vT6pCaFSf3S6VcQGMtB7uetVEp50oFaIrxu7vTVyzvKKflJo/zYoVAN9gcjSFhLF7i
         5QWrpkNR39kAesNm5TS8MNimooN4G2JyexemXWendZ6LRG3EcKx+D3RyNb+eExRGWD4L
         RZClh1gPGZudRRFH/iBEQ6SipyUPeW6CrBPRAainCCH8bWZ8kz+etZYMos1RSCaUT/A0
         LXPw7FiAi83TYRf14b1CZXNHdz45qA+blEYSkSK8JcbuJU1HBIWtMyato4lwu87BsBDl
         Mhu4KtTLR55CUc8owX2Wwu7RM5JvQTKbQA9Gad5p59iPCnJKQjy31WXSHUJ1yI5uMWys
         RGqA==
X-Forwarded-Encrypted: i=1; AKwUvBz+6KGDLPLtw27VgQSQ3N9bt7IYPTOrrVq1YoODbIZ5LIQBdh31ocTkS4UOPEFuKorWTB+ba2Sqfwg+cvIJ@vger.kernel.org
X-Gm-Message-State: AFq9FYKZuWArmPFuMbswK6cKZfOh9loIn9vh+BCjpDjQJ8XS3nwti8uM
	5RA8mqukSZpQ7Pt1JnvaFbPGQrJH+7y00P5ApcD1MBcwtFpbqCALt+hyOEfdQOcZmJs=
X-Gm-Gg: AYBFou1bhoETWzykSHEMmgwa6FPay/BrFnYwdUlU3If1Cank7rmXrzn4fMwPpXWn1Vx
	UaXMAl+MDkmy8p1FIfZWUypl65qWO1BAXvZQw8iZX8VqWyal8DYp44foWx/c1EqEU2TwrvkfY9K
	ypvD2CI0EOXHUwO+IS0tTfoiPJMa/cxB9CEo0eZnN+jRjAy029PrD8O8sZe3vLXa3EJpLhinPlf
	QSc00OslVW7vTJgzqXf1xJjb76yq/Eh6vTiZSmpe2tW0XU3lceri/HOphre3/s5ufDkdgMSBSof
	qDGNdFyOj3bvA+GTLXeywMj3kGzcY/uTFGmrygx1a1sQfd2oiwi90Mil7EUZpSttvRr/aAfZxur
	d/HJZuoTK6D4mt1bH84VNiCWItNxWKxtYePFPFlKgwibiYcU1b8CSZruroZX4ja1ZT2Lt3EFye1
	pfFvzBdY5V/WNP+b9bXjpn2skbdeeeOluITSOJlJbF9aNPsr2HBvd/j2ACuxI0V4r9fxsmVQqnz
	piK9606I8GGmys+yT3bVLnIHYsOePaCb0iB4HIE9A3BOJNzhDTPymtatfu2kZ/ShSmsAkEf4qC/
	j7nZgiGjvFkL+Ww=
X-Received: by 2002:a17:90b:4acc:b0:3aa:6b5d:a02e with SMTP id 98e67ed59e1d1-3ab3ac91dcfmr6500526a91.54.1791728994872;
        Sun, 11 Oct 2026 07:29:54 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm12551612a91.0.2026.10.11.07.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 07:29:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 14:29:53 +0000
Message-Id: <DM22X4LJYTQ9.1LK8R0L1FENWN@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <jolsa@kernel.org>
Cc: <ihor.solodrai@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <qmo@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <emil@etsalapatis.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <tj@kernel.org>, <kees@kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>,
 <puranjay@kernel.org>, <yatsenko@meta.com>, <atenart@kernel.org>,
 <ojeda@kernel.org>, <linux-modules@vger.kernel.org>,
 <arnaldo.melo@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 6/7] selftests/bpf: Test BTF sysfs inline
 representations
In-Reply-To: <20261009112324.1442319-7-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com> <20261009112324.1442319-7-alan.maguire@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 12:23 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> +		if (stat(inline_path, &st)) {
> +			err = errno;
> +			if (err != ENOENT)
> +				ASSERT_OK(err, "stat_inline_btf");
> +			btf__free(module_btf);
> +			continue;
> +		}

CONFIG_DEBUG_INFO_BTF_INLINE is not in selftests/bpf/config, so in CI
every iteration ends here and btf_inline from patch 7 is skipped.
CI is green without running any of the new code.
Pls add the config.
CI builds pahole from master, so 'inline' has to be there too.
