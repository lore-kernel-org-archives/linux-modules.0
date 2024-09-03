Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25A1A2621
	for <linux-modules@vger.kernel.org>; Tue,  3 Sep 2024 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362585; cv=none; b=isneEskARXlLu6q4X7cp0KSeyWf5ObwMx64dfLPMd7aWZE12uZ2ZKEIfENusH+7hmnv0zSuR7b4aiVSkX74fwoyeN8bCbeVWv+ChK387QtRrMLq9Q/FpmcuvR9Oii013wgv/X8UCRfzJP8DmuExzl/rIgsyoeE8kRnYzY3JNTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362585; c=relaxed/simple;
	bh=bJZp7v9VF/zV4FIdUkvtoSwQVPiQZ4CIEegB9jZ1ems=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ge7/HSZsj3Vq+ENy5LDGM9ZXwCIBJVxqPz61c5wvS6rayAw4Pz1X3Z5I2C4cDH/uRxtg28e49d8k+RVTEYUJCa7FxDi8zAIPBXq86YIB8G1vPyM7xxRJp1jF5HaaqJYVQhTcugGvXM6D8TiAhgd4Tz7g/jZJ43OG83RZqn22jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PFT6Aiyp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PFT6Aiyp"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8682bb5e79so634519166b.2
        for <linux-modules@vger.kernel.org>; Tue, 03 Sep 2024 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725362580; x=1725967380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4IcuQeuiymqaS/a1RhzzDSLXJUOsYIq0tu0n3fb8ks=;
        b=PFT6Aiyphmh4O3azCZhqdkp3AU/wdEZCCJYVuMRA1izQyj7ADd3DmFtUUdKvvL7WzB
         WgoHOM1iQok10Sd0K0GWUEfiDW7E7m1H2P9sUIv8vZnGtsalgP86/SBobP1XK1Uc2M3G
         BRoS7QnatYgs9b+BnayTw/vgfK9i2OAxYpRkrIWT3v99o5o1bmYLSEVZLkD2aDuafOML
         sEkyc8tiHYluymJAQtU/USkD18czTSwOAfB1l6cLU7FQitHu3opFpegNYaWPNe8SOMFI
         r8u7NEx6QyRM0etVutufaFnsXGVpfJoeGxoYZXQl6p0DLYP0B2p3O6hP7As+rQtXY02m
         XC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725362580; x=1725967380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4IcuQeuiymqaS/a1RhzzDSLXJUOsYIq0tu0n3fb8ks=;
        b=wfxPHfkT/G8e43pDfttTCy/lPghXWmt5rAXjj/2t2z4PTY6L1Kvcw9gSOmuN2CbRAv
         hxr6DiQtSXRhObcwuQsb3A6/v9dnfywJLR4Dm17liDEdhrahB4s24oEddP2wGa0EBD2D
         wFiCMUJdBpV1ST9KUGSI8O7G6E9QSCBtSsr0MXmbhQ2+sCplQrKinZxzMFbj4T6Gpcgd
         uv8guTZWtnyZSISeUQWT0PZ6f7MyLZsoVVMK4bFlHla5Gl0b12IKCuOlwHSYBrKDeucI
         byQ1WDtkDQ6pcq+EBfZV+CuS076uu8Mi3/6w8/j9QfswpljYKNUjUnVV1JL/VVcovUkT
         uRDw==
X-Forwarded-Encrypted: i=1; AJvYcCW88RMVKiLakWBtKbFuiGPjeQxSyL38Hkzo20WdP55SVQnY/GG69uViSdy4mOT6eUMymi6L5K+Db7isVO6B@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZt4adKOKApDabnRTzuLL0eKkN6N0bW0Lfu7LJO6vBAcpGqKO
	nPpY50T+zfBXEiiFHTa9yLMgvgo4vYRBU6HQ5zPzWJNBEGLVlF/ZNAMzzRYSrDU=
X-Google-Smtp-Source: AGHT+IHuKeLghdg/ls1i2JFJtmfoByQgn6d7Wd00RW7FnQCnrsmyQ9cHM02wmJzDXMutnkx6CANOYw==
X-Received: by 2002:a17:906:9c84:b0:a86:77ac:7e4e with SMTP id a640c23a62f3a-a89fae1b87emr516226866b.34.1725362579557;
        Tue, 03 Sep 2024 04:22:59 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feae4dsm673991766b.31.2024.09.03.04.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:22:59 -0700 (PDT)
Message-ID: <c50f5364-ca94-4d5b-be99-3a3ffcf79648@suse.com>
Date: Tue, 3 Sep 2024 13:22:58 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: abort module loading when sysfs setup suffer
 errors
To: Chunhui Li <chunhui.li@mediatek.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 wsd_upstream@mediatek.com, Xion Wang <xion.wang@mediatek.com>
References: <20240830054400.26622-1-chunhui.li@mediatek.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240830054400.26622-1-chunhui.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/24 07:43, Chunhui Li wrote:
> When insmod a kernel module, if fails in add_notes_attrs or
> add_sysfs_attrs such as memory allocation fail, mod_sysfs_setup
> will still return success, but we can't access user interface
> on android device.
> 
> Patch for make mod_sysfs_setup can check the error of
> add_notes_attrs and add_sysfs_attrs

s/add_sysfs_attrs/add_sect_attrs/

I think it makes sense to propagate errors from these functions upward,
although I wonder if the authors of this code didn't intentionally make
the errors silent, possibly because the interface was mostly intended
for debugging only?

The original commits which added add_sect_attrs() and add_notes_attrs()
don't mention anything explicitly in this regard:
https://github.com/mpe/linux-fullhistory/commit/db939b519bea9b88ae1c95c3b479c0b07145f2a0
https://github.com/torvalds/linux/commit/6d76013381ed28979cd122eb4b249a88b5e384fa

> 
> Signed-off-by: Xion Wang <xion.wang@mediatek.com>
> Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>
> ---
>  kernel/module/sysfs.c | 49 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index 26efe1305c12..a9ee650d995d 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -69,12 +69,13 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>  	kfree(sect_attrs);
>  }
>  
> -static void add_sect_attrs(struct module *mod, const struct load_info *info)
> +static int add_sect_attrs(struct module *mod, const struct load_info *info)
>  {
>  	unsigned int nloaded = 0, i, size[2];
>  	struct module_sect_attrs *sect_attrs;
>  	struct module_sect_attr *sattr;
>  	struct bin_attribute **gattr;
> +	int ret = 0;

Nit: It isn't necessary to initialize this variable to 0 because the
code explicitly does "return 0;" on success. While on the error path,
the variable is always assigned.

>  
>  	/* Count loaded sections and allocate structures */
>  	for (i = 0; i < info->hdr->e_shnum; i++)
> @@ -85,7 +86,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
>  	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
>  	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
>  	if (!sect_attrs)
> -		return;
> +		return -ENOMEM;
>  
>  	/* Setup section attributes. */
>  	sect_attrs->grp.name = "sections";
> @@ -103,8 +104,10 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
>  		sattr->address = sec->sh_addr;
>  		sattr->battr.attr.name =
>  			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
> -		if (!sattr->battr.attr.name)
> +		if (!sattr->battr.attr.name) {
> +			ret = -ENOMEM;
>  			goto out;
> +		}
>  		sect_attrs->nsections++;
>  		sattr->battr.read = module_sect_read;
>  		sattr->battr.size = MODULE_SECT_READ_SIZE;
> @@ -113,13 +116,16 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
>  	}
>  	*gattr = NULL;
>  
> -	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp))
> +	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp)) {
> +		ret = -EIO;
>  		goto out;
> +	}

Why does the logic return -EIO instead of propagating the error code
from sysfs_create_group()?

>  
>  	mod->sect_attrs = sect_attrs;
> -	return;
> +	return 0;
>  out:
>  	free_sect_attrs(sect_attrs);
> +	return ret;
>  }
>  
>  static void remove_sect_attrs(struct module *mod)
> @@ -158,15 +164,16 @@ static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
>  	kfree(notes_attrs);
>  }
>  
> -static void add_notes_attrs(struct module *mod, const struct load_info *info)
> +static int add_notes_attrs(struct module *mod, const struct load_info *info)
>  {
>  	unsigned int notes, loaded, i;
>  	struct module_notes_attrs *notes_attrs;
>  	struct bin_attribute *nattr;
> +	int ret = 0;

Similarly here, the initialization is not necessary.

>  
>  	/* failed to create section attributes, so can't create notes */
>  	if (!mod->sect_attrs)
> -		return;
> +		return -EINVAL;

Since the patch modifies mod_sysfs_setup() to bail out when registering
section attributes fails, this condition can no longer be true and the
check can be removed.

>  
>  	/* Count notes sections and allocate structures.  */
>  	notes = 0;
> @@ -176,12 +183,12 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
>  			++notes;
>  
>  	if (notes == 0)
> -		return;
> +		return 0;
>  
>  	notes_attrs = kzalloc(struct_size(notes_attrs, attrs, notes),
>  			      GFP_KERNEL);
>  	if (!notes_attrs)
> -		return;
> +		return -ENOMEM;
>  
>  	notes_attrs->notes = notes;
>  	nattr = &notes_attrs->attrs[0];
> @@ -201,19 +208,24 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
>  	}
>  
>  	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
> -	if (!notes_attrs->dir)
> +	if (!notes_attrs->dir) {
> +		ret = -ENOMEM;
>  		goto out;
> +	}
>  
>  	for (i = 0; i < notes; ++i)
>  		if (sysfs_create_bin_file(notes_attrs->dir,
> -					  &notes_attrs->attrs[i]))
> +					  &notes_attrs->attrs[i])) {
> +			ret = -EIO;
>  			goto out;
> +	}

Similarly here, the actual error from sysfs_create_bin_file() can be
returned.

>  
>  	mod->notes_attrs = notes_attrs;
> -	return;
> +	return 0;
>  
>  out:
>  	free_notes_attrs(notes_attrs, i);
> +	return ret;
>  }
>  
>  static void remove_notes_attrs(struct module *mod)
> @@ -385,11 +397,20 @@ int mod_sysfs_setup(struct module *mod,
>  	if (err)
>  		goto out_unreg_modinfo_attrs;
>  
> -	add_sect_attrs(mod, info);
> -	add_notes_attrs(mod, info);
> +	err = add_sect_attrs(mod, info);
> +	if (err)
> +		goto out_unreg_sect_attrs;
> +
> +	err = add_notes_attrs(mod, info);
> +	if (err)
> +		goto out_unreg_notes_attrs;
>  
>  	return 0;
>  
> +out_unreg_notes_attrs:
> +	remove_notes_attrs(mod);
> +out_unreg_sect_attrs:
> +	remove_sect_attrs(mod);

Upon a failure from add_sect_attrs(), the caller doesn't need to unwind
its operation. It is the responsibility of add_sect_attrs() to clean up
after itself on error. Instead, the code in mod_sysfs_setup() needs to
unwind all previous successful operations leading up to this point,
which means here additionally to invoke del_usage_links().

I think you want something as follows:

err = add_sect_attrs(mod, info);
if (err)
	goto out_unreg_usage_links;

err = add_notes_attrs(mod, info);
if (err)
	goto out_unreg_sect_attrs;

return 0;

out_unreg_sect_attrs:
	remove_sect_attrs(mod);
out_unreg_usage_links:
	del_usage_links(mod);
[...]

>  out_unreg_modinfo_attrs:
>  	module_remove_modinfo_attrs(mod, -1);
>  out_unreg_param:

-- 
Cheers,
Petr
