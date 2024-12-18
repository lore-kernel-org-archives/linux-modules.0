Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88ED1C2304
	for <linux-modules@vger.kernel.org>; Wed, 18 Dec 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527592; cv=none; b=ZQ9kLYnV/qyDNE4litZQ+CNp5jvmT/2EHgiQPJNgnUfxMaqvw+9vlyOZ6xX6x5cBWnfPpySTEwmNDl5t5QVxzAp1GNdOk5JIM+XiMOW7oihp/a1Ag2O+KfeK5X3gjjSB67XLcQ7Mg7wARut4DBXRqJ7JdQBWA+VdnoiKm/59x/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527592; c=relaxed/simple;
	bh=flfzf+1v6xrkFqqSLclzpX/3khQ9UCg1Db/MPkBxR/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+1h3ActGaQmUcuSEeLMisBYpQ0JcWZtz76G8UPXiqpbcv15foyiqW9q8m0a/J+v30beITzheSvg7rwFUw3ORQmxm7LWYUgyowXDyZZ/sGeoTaiC5lwDrESHR8HUap8JfkDjmUrQ/AQ91KH53C0V+QsU9ZfNkMh1D9az9bZlqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cV6fQioX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cV6fQioX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863494591bso3492920f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 18 Dec 2024 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734527588; x=1735132388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1v56/EV4D9e/6GoTwOWA0bGxJ3j+5jflW0Kr/NWi5Q=;
        b=cV6fQioXpUrJERXCvvQGndqPY0RxeXLWAsg33jWQ9up9ba7bjDcIsg+tmVcA9FNwSF
         e0CURKwbwbrGWUb2gE2kiSzUh1A/xYwkUrTwulkVO1jOuPx7FAQODcsJc79+rj6UOr7k
         /EFdFvnuW73qO89O94XkAyHawds3t9lHlDoyEy2ERYUM8qlLJMLy55TFGgnEL9qxdl7i
         DiSGOomIFZomKuV7qMM2F2N3/41P436QWa/rxjMec2Q5jy1iCnqAm42d64j9Bel8/77O
         b9Vc0S2veJnOw6L/pGkwBTBt93ePwBNQ80zEwpVCAuSQwlbNIYRhYUhjQlNZESXJQcTM
         uS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527588; x=1735132388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1v56/EV4D9e/6GoTwOWA0bGxJ3j+5jflW0Kr/NWi5Q=;
        b=jsp2yjT5sYJsJxTS1wVo41dV8AyCj5WoQxEGirX+Iu6XQUjTo1z0P9kZ5OSujXoLVh
         kwpYphjlAudxLJOk0MlOPTu2JY2gcN/7Mq6R+I+r4Ecs82OpylbzdhK/Jq0zt+ZYbQUx
         U9TLjpG0kDN9kRTFDry1aKdT6SMDWGJLuwIoWzhwdmgF0NfBJgIJXnXzYXAjjwgRHRnH
         Xq3OpP3CGqrVBybOjGm1DpHVuQ5V0EgqoPdXNFRh4ewxfjTNxvV8raxOWUJK3r17Q1ey
         bnlxuTaDZn8UDlrV4u+s6Qx/Z9A4pzcDSpQ0tq50zZ+BvLBtqDjX+2byv4u43Ty8pVvS
         j/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVyTK8WkYhRF5xz4F8YpVvf7M9qAAWFtqBw70+126+LGT12OPhk8urfia1LrjkfF+hBiyEVDjBirQY/dHt6@vger.kernel.org
X-Gm-Message-State: AOJu0YzsrSKDBHyNEKiZZxO0BAUZcoWLsIJ7TMiUuJVDJlrKYVnFGb/X
	P1GyxXnigrgbkDvWla9OC4xlwKOHy5Zl+V8IJUY/86cJXfqKQDuRJjRQ3Pf5z7k=
X-Gm-Gg: ASbGncsDEwAbhaQ1ZG76VOkrjpZ8oelk4fP127lmSBox5N/x1TAhWd+HsXmMgB31osp
	7xJ4csa6cb2KQBL0BWTqvnAU6OTMAMMxPJpj4EeqxGXhWP+GteT9SzLkKBeYDBIk52oWT4zmG5+
	2P/gCAxbmbJHMhnrJ9v4GLWlXpTSAbBQ/uIM6E/Y2TYPQoL1k+BZG2AsTDBLE8FZNIIrQmkVSTn
	Qq2j3KwLHlvaJ9LBCuyjYcYkz0hrlL8M3rbsoD0eF7hV3czw61od9PYWYAK
X-Google-Smtp-Source: AGHT+IHT/CtokUUGY0vYXZy93Zbizf7SkexZLG1ckSHUO//w/wQnpeCrYRC1yvo/FhiVr2Asbgvlog==
X-Received: by 2002:a5d:47c3:0:b0:385:f062:c2df with SMTP id ffacd0b85a97d-388e4d6a2c9mr2983816f8f.11.1734527588144;
        Wed, 18 Dec 2024 05:13:08 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060848sm14035400f8f.106.2024.12.18.05.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 05:13:07 -0800 (PST)
Message-ID: <4ed64526-9ef0-49ed-ae97-a0df89136f89@suse.com>
Date: Wed, 18 Dec 2024 14:13:07 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] module: sysfs: Add notes attributes through
 attribute_group
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net>
 <20241216-sysfs-const-bin_attr-module-v1-3-f81e49e54ce4@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241216-sysfs-const-bin_attr-module-v1-3-f81e49e54ce4@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 20:16, Thomas Weißschuh wrote:
> A kobject is meant to manage the lifecycle of some resource.
> However the module sysfs code only creates a kobject to get a
> "notes" subdirectory in sysfs.
> This can be achieved easier and cheaper by using a sysfs group.
> Switch the notes attribute code to such a group, similar to how the
> section allocation in the same file already works.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  kernel/module/sysfs.c | 48 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index 935629ac21fa16504ddb5f3762af5539572c3bf1..4f37970f99c999589257713926395686f03103e6 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -145,20 +145,17 @@ static void remove_sect_attrs(struct module *mod)
>   */
>  
>  struct module_notes_attrs {
> -	struct kobject *dir;
> -	unsigned int notes;
> -	struct bin_attribute attrs[] __counted_by(notes);
> +	struct attribute_group grp;
> +	struct bin_attribute attrs[];
>  };
>  
> -static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
> -			     unsigned int i)
> +static void free_notes_attrs(struct module_notes_attrs *notes_attrs)
>  {
> -	if (notes_attrs->dir) {
> -		while (i-- > 0)
> -			sysfs_remove_bin_file(notes_attrs->dir,
> -					      &notes_attrs->attrs[i]);
> -		kobject_put(notes_attrs->dir);
> -	}
> +	struct bin_attribute **bin_attr;
> +
> +	for (bin_attr = notes_attrs->grp.bin_attrs; *bin_attr; bin_attr++)

Similarly as commented on patch #2, this results in a NULL dereference
when add_notes_attrs() fails to allocate gattr.

> +		kfree((*bin_attr)->attr.name);

This line causes that the name string is freed twice on a module
unload, here and in free_sect_attrs(). Notice that function
add_notes_attrs() takes each name directly from mod->sect_attrs, without
calling kstrdup():

nattr->attr.name = mod->sect_attrs->attrs[loaded].battr.attr.name;

> +	kfree(notes_attrs->grp.bin_attrs);
>  	kfree(notes_attrs);
>  }
>  
> @@ -166,6 +163,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>  {
>  	unsigned int notes, loaded, i;
>  	struct module_notes_attrs *notes_attrs;
> +	struct bin_attribute **gattr;
>  	struct bin_attribute *nattr;
>  	int ret;
>  
> @@ -184,7 +182,15 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>  	if (!notes_attrs)
>  		return -ENOMEM;
>  
> -	notes_attrs->notes = notes;
> +	gattr = kcalloc(notes + 1, sizeof(*gattr), GFP_KERNEL);
> +	if (!gattr) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	notes_attrs->grp.name = "notes";
> +	notes_attrs->grp.bin_attrs = gattr;
> +
>  	nattr = &notes_attrs->attrs[0];
>  	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
>  		if (sect_empty(&info->sechdrs[i]))
> @@ -196,35 +202,27 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>  			nattr->size = info->sechdrs[i].sh_size;
>  			nattr->private = (void *)info->sechdrs[i].sh_addr;
>  			nattr->read = sysfs_bin_attr_simple_read;
> -			++nattr;
> +			*(gattr++) = nattr++;
>  		}
>  		++loaded;
>  	}
>  
> -	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
> -	if (!notes_attrs->dir) {
> -		ret = -ENOMEM;
> +	ret = sysfs_create_group(&mod->mkobj.kobj, &notes_attrs->grp);
> +	if (ret)
>  		goto out;
> -	}
> -
> -	for (i = 0; i < notes; ++i) {
> -		ret = sysfs_create_bin_file(notes_attrs->dir, &notes_attrs->attrs[i]);
> -		if (ret)
> -			goto out;
> -	}
>  
>  	mod->notes_attrs = notes_attrs;
>  	return 0;
>  
>  out:
> -	free_notes_attrs(notes_attrs, i);
> +	free_notes_attrs(notes_attrs);
>  	return ret;
>  }
>  
>  static void remove_notes_attrs(struct module *mod)
>  {
>  	if (mod->notes_attrs)
> -		free_notes_attrs(mod->notes_attrs, mod->notes_attrs->notes);
> +		free_notes_attrs(mod->notes_attrs);
>  }

If the patch tries to unify handling of sect_attrs and notes_attrs,
should remove_notes_attrs() call also sysfs_remove_group() and reset
mod->notes_attrs to match what is done in remove_sect_attrs()?

>  
>  #else /* !CONFIG_KALLSYMS */
> 

-- 
Thanks,
Petr
