Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85323B0584
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809691; cv=none; b=c9DLq3anDD7iQzMsmS0AX3GwYm1/EsKxCnG6P+pfUAFz5qayA9mcNo+/9GU+qRvh6YCPaNyKU1JUPHSUtUXZpHSyFgjNxGcqAdmk0QPGAoysPlIOLoR5JcfzLGbevzJm8Ev90GQCa7SVFju+FeuCQTK969hDzKYxHJhcrlbpEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809691; c=relaxed/simple;
	bh=btx1+Owere5ZdnPjKvkD7SvEDGZGZdrVSp3lVn2MauY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OncCbRpro7e9jxbU3UwXymsS0NaIjWYjJ8REDsGZQ2fW4VUxEABilMQ3YiIzTlaw/2uQm4mhyGAuP5yg+1dyyVH5GQNUr83ZTv+1wLDkqj0jJLzxPJWFRfVn21oa8IjoknZtcwHktvXkPjnX8sTBeyZDhSzfxKwMSrWjxnCVeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shpOgElP; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shpOgElP"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b12d146e6fso1710223eaf.0
        for <linux-modules@vger.kernel.org>; Mon, 07 Sep 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809689; x=1789414489; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nz5/hCF3ASsSc7pKpGQL7Ee5bF0555Kuy5t3SLPT87o=;
        b=shpOgElPFci0zR6NDvtWmJBZg15rEMxA5H8o4VsHWKzdWX0LQRIeT5t1KZTrxLAWwe
         HTHlkGHzC2AO0fMWkYMfP8qHvwHjaAQeviTXadu0Bx6nFcfdb+Pw423qweJT8R7FpJq7
         aFyVqr0QH6mVZUnXFwVJDaHSPWwHOdTMSiwOBCzkaJVRGY04tXiZfBla0UvQGro3lKcP
         DjsVuJI0+ReAHUmjdHeFzZWZMuB/aYsCoDNReY16WcSoyny3JICmToAr/fMSItZ5Cqw1
         sGER4axDSpxfIPwRoIH4lX5K+aLuQlbOtWkYXannRzVWgitj8elMPtAdcz9bMUBTszfi
         LW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809689; x=1789414489;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nz5/hCF3ASsSc7pKpGQL7Ee5bF0555Kuy5t3SLPT87o=;
        b=L3EdHXaykKtWXugfUl3R5W69TzWAQ1r07VhZsPtq2s4rLmv5Ob+T7bqeGVXmdQsgEt
         Yc8TrcAdh7QprEdfluoRnzzsPfsVUj3eRewAClVXLStebrfwVXB0HvB+jdP/XiPSl5fv
         NqptWHgRVn4htEOCjIQXMo1Y1kWh+4KQOv0BWpH137F4onIfFmeDdhginZraBOlXJZ5K
         2ezVmHfkj16g/6rM0KP7dY4rEvgyLaxAbPmljBAyDK2ryPR1hp51sRRKCwYZ59srEwFM
         mx7V4nCkqe1zfgoxFN+lsDuvE65kwPf07ZFo3M8q68jEPYc/lYlleddb0WJibBDRKEyE
         ehRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7GuyweWE0z7SAoeKr6ASCGCASYxz6mkq21tYpX3zLjOAVvkSbAbFQoAREcrt8HZO+agPxBoa0ndEwK1/3@vger.kernel.org
X-Gm-Message-State: AFuF++lbbZlNrvj8svKPr985BF9JcR/jCdmfIEkmEKJOgH4/esB98l7P
	rDtJFjOJwHoC9uqXzriVEdfe5pnyolGQ+3zLi7fTv+9QFObTBdOx1ojb
X-Gm-Gg: AYBFou1SbnXgfmAs3XGoIOi4/6l8sQCinurb6umQI1OVSbssnAUyoU9pdmkH2Qt8UvB
	f62aQV3TeHoXmvPYq4CpM/QOGvJaCx87C81ykA9TWIJcYY1iJwnENjyFr8u3apyags4Qm8pmd4o
	NVW1cHa3D5ekH0lhpUBEnsc0nuVElyTNDCJLVyV/hc+dg5Ych3rxUciT4keR56jV05Khq8Ohp0C
	ikIDd5eU3oltBvjnrt00BOY9Ag2Y6ZLgxeh+7Es/M+aJb5+kgYQQTRbkxDvnYqO9R6FwBNbj/CF
	rfmLy+9FYQ1bDfBuAjvCnNTwn/i3VgmO7OGTvwT8sihyx7CyKFrhRdVvVSXb09rxS+9MXgQslIK
	8XCd16JUoimMOjG6og7ImSfZ0LroIrMHFjN0IKid2AlTRpY93HzdOTmDSMLK9vvZn9IAkwFfsXW
	8X2vkG2PL7ggk9adjhP/6LbIPfZEHymGHk597JVrerd3vi2nvkJmUd+15lIfSYgA47AhmpJbTNX
	52WT4gU97uJsIfyWOtS+iL6aUFJ5aMCZYZQH5ZH0orwa6/kIWodfdk=
X-Received: by 2002:a05:6820:198e:b0:6b8:5906:2c11 with SMTP id 006d021491bc7-6b859062c8cmr9342962eaf.8.1788809688469;
        Mon, 07 Sep 2026 12:34:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47989a71ebbsm1800827fac.17.2026.09.07.12.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 12:34:45 -0700
Message-Id: <DL9C40S8FVWA.2T4J5Y8BSF7KU@gmail.com>
Cc: <daniel@iogearbox.net>, <eddyz87@gmail.com>, <jolsa@kernel.org>,
 <ihor.solodrai@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <qmo@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <emil@etsalapatis.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <tj@kernel.org>, <kees@kernel.org>, <bpf@vger.kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <arnd@arndb.de>,
 <puranjay@kernel.org>, <yatsenko@meta.com>, <atenart@kernel.org>,
 <ojeda@kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 14/18] btf: Make vmlinux, module inline info
 available in /sys/kernel/btf
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>,
 <andrii@kernel.org>
X-Mailer: aerc
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-15-alan.maguire@oracle.com>
In-Reply-To: <20260901165757.801449-15-alan.maguire@oracle.com>

On Tue Sep 1, 2026 at 9:57 AM PDT, Alan Maguire wrote:
> Expose BTF inline-location information from vmlinux/module .BTF.inline
> sections in /sys/kernel/btf using a ".inline" suffix.
>
> vmlinux inline BTF is split relative to vmlinux BTF and can be examined
> with:
>
> bpftool btf dump file /sys/kernel/btf/vmlinux.inline
>
> Register the sysfs attribute only when the embedded .BTF.inline section
> is non-empty.
>
> Module inline BTF is split relative to the module BTF, which in turn may
> be split relative to its distilled base BTF.  For example:
>
>     bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs \
>             file /sys/kernel/btf/xfs.inline
>
> Copy the inline BTF data into a private buffer for its sysfs lifetime
> and remove the attribute and buffer when the module is unloaded.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/btf.h             |   1 +
>  include/linux/module.h          |   4 ++
>  kernel/bpf/Makefile             |   1 +
>  kernel/bpf/btf.c                | 109 ++++++++++++++++++++++++++------
>  kernel/bpf/btf_vmlinux_inline.c |  30 +++++++++
>  kernel/module/main.c            |   4 ++
>  6 files changed, 128 insertions(+), 21 deletions(-)
>  create mode 100644 kernel/bpf/btf_vmlinux_inline.c
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index a4412bc16688..93f10d3ccabe 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -617,6 +617,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log,=
 enum bpf_prog_type prog_ty
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2);
>  int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int=
 arg_idx);
> +struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t=
 data_size);
> =20
>  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct =
btf_type *t)
>  {
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..3d32c4e86f44 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -507,6 +507,10 @@ struct module {
>  	void *btf_data;
>  	void *btf_base_data;
>  #endif
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
> +	unsigned int btf_inline_data_size;
> +	void *btf_inline_data;
> +#endif
>  #ifdef CONFIG_JUMP_LABEL
>  	struct jump_entry *jump_entries;
>  	unsigned int num_jump_entries;
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 9a92c348bbda..60aa5adb0354 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D reuseport_array.o
>  endif
>  ifeq ($(CONFIG_SYSFS),y)
>  obj-$(CONFIG_DEBUG_INFO_BTF) +=3D sysfs_btf.o
> +obj-$(CONFIG_DEBUG_INFO_BTF_INLINE) +=3D btf_vmlinux_inline.o
>  endif
>  ifeq ($(CONFIG_BPF_JIT),y)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_struct_ops.o
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d74c8668aa3f..3e5890aed2db 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8735,12 +8735,69 @@ enum {
>  	BTF_MODULE_F_LIVE =3D (1 << 0),
>  };
> =20
> +#if IS_ENABLED(CONFIG_SYSFS)
> +struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t=
 data_size)
> +{
> +	struct bin_attribute *attr;
> +	int err;
> +
> +	attr =3D kzalloc_obj(*attr);
> +	if (!attr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sysfs_bin_attr_init(attr);
> +	attr->attr.mode =3D 0444;
> +	attr->size =3D data_size;
> +	attr->private =3D data;
> +	attr->read =3D sysfs_bin_attr_simple_read;
> +	attr->attr.name =3D kstrdup(name, GFP_KERNEL);
> +	if (!attr->attr.name) {
> +		err =3D -ENOMEM;
> +		goto err_free;
> +	}
> +	err =3D sysfs_create_bin_file(btf_kobj, attr);
> +	if (err) {
> +		pr_warn("failed to register [%s] BTF in sysfs: %d\n", name, err);
> +		goto err_free;
> +	}
> +	return attr;
> +
> +err_free:
> +	kfree(attr->attr.name);
> +	kfree(attr);
> +	return ERR_PTR(err);
> +}
> +
> +#else
> +struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t=
 data_size)
> +{
> +	return NULL;
> +}
> +#endif

We do
ifeq ($(CONFIG_SYSFS),y)
obj-$(CONFIG_DEBUG_INFO_BTF) +=3D sysfs_btf.o
endif

I would do the same here and avoid ifdef inside .c

Also consider adding support for mmaping of vmlinux.inline
from the start.
It was useful for regular BTF. BTF.inline is bigger,
so it will benefit more.

Some of AI bug reports sound valid. Pls address and respin.
Let's start landing it asap.

pw-bot: cr
