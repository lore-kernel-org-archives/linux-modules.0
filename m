Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7333F5A0
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749974; cv=none; b=VqRioByxH7cJJIxgpQn8L9aHIlnmPSM5qtiOzzoYBigZDvX+S9LcvSiZIQkdIiB7b3INHn+Y2/RfJRTww7iqizrcNjJzYnqqUU1jLNzCJy4yXVNiVZHB7N7ZSUAkgKUVMJD6dmDhNwlp3/bQi8WloFCHdCrcIr3kcz8x6FWiDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749974; c=relaxed/simple;
	bh=MglYxuye+f6mi7DlYbR0pjhnIPwFYCOCLfH+Kswlkm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rokbDKUjrPquUioqCkV30fhAR2nqrLra66+aqg3aK6/qdOvz6Zy5UoLsmh7L2CbuvGgWHZ8m/ZTe/bkGGYJNM6I3LrG/Dhrge8EjXQ13ZkRWPG1VoVL7WrH/weBwi28faqDjWNpe8mqc0xKThsMYlozSN4Gbziw2s1EOBhPAZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qolQ047o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qolQ047o"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae49120e97so27305ad.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 14:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772749971; x=1773354771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7dtkvH98TyYtXXMGFbwc3ykk2Hwk5qV14QGB+DUa00=;
        b=qolQ047oER3xWZChKug56AJRSYSyFzFCX9BFa3Jc/OQmd9lFCdjrzsrZcn+gaTaam1
         rDKQVFxhRPwRRCZRi0iCbg0MhTqyIN21cd6CPLbN8uduyoDTQxZ9Henb/xPOo9vwMuh6
         AWYqeC9JfTZr/JVag3X6rx+kaTkklteJyC2x3MTiac0qOKvQzmeyO4CdQTwrPQgEm38n
         JQn06Ndn41CfFJ/BBX7CNN+Us7om7I7IWLH8CPYSVriVokMNklIDUB6IXB13/1xgfyRo
         G4EyUsDohH0iZWF1WZ5U5OZ3LZPh6WgShM5r3MBAyvV5bOsV5hT/Ec55QPrV8hVYwbof
         +lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749971; x=1773354771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7dtkvH98TyYtXXMGFbwc3ykk2Hwk5qV14QGB+DUa00=;
        b=Ciu7/kHnIg2COrDVfSI5pxLhYPTExf7u0TKpO3kWguXzLqqfOYl+iDnQUbuD5WCT8s
         s7pogUMCcBWQX7bLp3+Q2qRYBjHRmM1ZZbCyD61VsHK+z7GCIPTJfy6PlvZeNUWyZX6K
         ZLFmG2a8mZiwH6PE5ekV9c5H3pXkhA/h7pFMLt/7M/0YKdG/Fd4T1H7daKF8Eo1uTDlY
         Grp3cvE5Xk2dXxy9uQf5JZuHLJoyqNMtK7Y4OhNVb+0jpXPBV5XsrUnhyXC8WvNY1yBS
         TOXIx0KrCm2i16JDJDZsr5/T7NsGFWE7gF1J8I/+tE2lXvIr79otP2DUarIsrLUuvwH+
         atog==
X-Forwarded-Encrypted: i=1; AJvYcCUd6teufsfb4SbSmnskgMooHtwA4mivzy99ND/18OblKsk8dF6wIRaVVGYsIWfeaq55vP5uFR91fTAN7Oc8@vger.kernel.org
X-Gm-Message-State: AOJu0YxZz31SofJgzk6dcxlRqV/VL//2KEn5xt6CCPX5qUEY9eKVDiuP
	Dp+4u2ZUYDI/Ughvwq4w+fBOlCbCmhZB9Wk57QcIFFOOwI20anqj/cP/8FCGJKe8Jw==
X-Gm-Gg: ATEYQzwVAZACAMvD+NWomTYR3KPRjDXhao0hTTQ07iF7CM4vpIMOO1CCQrN0SFXt+3g
	Q3EJxhCqiz86QRJr5IxnAb9ZJ/5AqoQ8NrEsGf793f+4VRiv1NyRfnObG0iRCPplsjTe2pvXK2s
	x4yvfl82jJMVKjkCKX8B2Rdj2Zuc9tXDuSkoIaYb+ETqso1NQY0p1kriAily3cvR4xPjrZNbaPV
	U/YdZQBDq6P1n6C3lWriXm4p/sCs5twIOnLAQ4X0JqHrqzIK0P8Y6NX0ty7E1zsBosBKiCiHoXI
	kDCY80EZm3X/Dc6FLuNpMEXz7Fjej6vbjyvtM4UF0fo/6P5jm0ejO4/PrsI15AGc3A5UeHxrH7K
	MnRka0/X63lUr150+xebtmTFerm+i+MXJURj718ksDXX8Gl9teMS9o/cZ5Nv3bJVN0sPw61Us3C
	A3+9E2jzQDkgs41wkaMrz2s2YxzCwdwcm0u1Y9n/FBppcPC5TgDlR1h1PeuSx/7I8yDZs=
X-Received: by 2002:a17:903:f90:b0:2ae:6432:8f77 with SMTP id d9443c01a7336-2ae81e8c6ffmr394105ad.17.1772749970601;
        Thu, 05 Mar 2026 14:32:50 -0800 (PST)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829751f3867sm5267441b3a.55.2026.03.05.14.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:32:49 -0800 (PST)
Date: Thu, 5 Mar 2026 22:32:45 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Nicholas Sielicki <linux@opensource.nslick.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Matthias Maennich <maennich@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: expose imported namespaces via sysfs
Message-ID: <20260305223245.GA732271@google.com>
References: <20260108044710.33036-1-linux@opensource.nslick.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108044710.33036-1-linux@opensource.nslick.com>

On Wed, Jan 07, 2026 at 10:47:09PM -0600, Nicholas Sielicki wrote:
>  
> +static ssize_t show_modinfo_import_ns(const struct module_attribute *mattr,
> +				      struct module_kobject *mk, char *buffer)
> +{
> +	return sysfs_emit(buffer, "%s\n", mk->mod->imported_namespaces);
> +}
> +
> +static int modinfo_import_ns_exists(struct module *mod)
> +{
> +	return mod->imported_namespaces != NULL;
> +}
> +
> +static const struct module_attribute modinfo_import_ns = {
> +	.attr = { .name = "import_ns", .mode = 0444 },
> +	.show = show_modinfo_import_ns,
> +	.test = modinfo_import_ns_exists,
> +};
> +

Don't we need a .setup function that initializes mod->imported_namespaces
to NULL? Currently, if setup_modinfo returns an error, the pointer remains
initialized to whatever value we read from .gnu.linkonce.this_module, and
we'll pass that arbitrary pointer to kfree.

This isn't normally a problem since modpost zero-initializes the field, but
we don't want to rely on userspace to initialize our pointers.

Also, define .free to release the buffer instead of adding a direct call
to free_modinfo.

>  static struct {
>  	char name[MODULE_NAME_LEN];
>  	char taints[MODULE_FLAGS_BUF_SIZE];
> @@ -1058,6 +1075,7 @@ const struct module_attribute *const modinfo_attrs[] = {
>  	&module_uevent,
>  	&modinfo_version,
>  	&modinfo_srcversion,
> +	&modinfo_import_ns,
>  	&modinfo_initstate,
>  	&modinfo_coresize,
>  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> @@ -1753,11 +1771,48 @@ static void module_license_taint_check(struct module *mod, const char *license)
>  	}
>  }
>  
> +static int copy_modinfo_import_ns(struct module *mod, struct load_info *info)
> +{
> +	char *ns;
> +	size_t len, total_len = 0;
> +	char *buf, *p;
> +
> +	for_each_modinfo_entry(ns, info, "import_ns")
> +		total_len += strlen(ns) + 1;
> +
> +	if (!total_len) {
> +		mod->imported_namespaces = NULL;
> +		return 0;
> +	}
> +
> +	buf = kmalloc(total_len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

For example, if kmalloc fails, mod->imported_namespaces isn't initialized.

> +
> +	p = buf;
> +	for_each_modinfo_entry(ns, info, "import_ns") {
> +		len = strlen(ns);
> +		memcpy(p, ns, len);
> +		p += len;
> +		*p++ = '\n';
> +	}
> +	/* Replace trailing newline with null terminator. */
> +	*(p - 1) = '\0';
> +
> +	mod->imported_namespaces = buf;
> +	return 0;
> +}
> +
> +static void free_modinfo_import_ns(struct module *mod)
> +{
> +	kfree(mod->imported_namespaces);

mod->imported_namespaces = NULL;

> +}
> +
>  static int setup_modinfo(struct module *mod, struct load_info *info)
>  {
>  	const struct module_attribute *attr;
>  	char *imported_namespace;
> -	int i;
> +	int i, err;
>  
>  	for (i = 0; (attr = modinfo_attrs[i]); i++) {
>  		if (attr->setup)
> @@ -1776,6 +1831,10 @@ static int setup_modinfo(struct module *mod, struct load_info *info)
>  		}
>  	}

Also setup_modinfo can fail before copy_modinfo_import_ns is even
called.

> +	err = copy_modinfo_import_ns(mod, info);
> +	if (err)
> +		return err;
> +

Sami
