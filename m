Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989F2D8370
	for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786765255; cv=pass; b=GmzcEApAlCeoas2C3tpTg/7XokQY5j1Vbk12pAWuZTAuZvreBXZAk+Q1QtA2kctTrVSJNoCdxYPd4rojpqVpg9B9ZtKiUMqUm0BHd0fDJQnNSdAIl1DnDOrMSrpS2KLnERzyWQrzh/6brbUY4UBIvVd9R6bwrXv399htkpDPNGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786765255; c=relaxed/simple;
	bh=+5hLXBTYRoTMw1xaNCoIkX0kfZwmouQsDqdHDwqd5KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=de0P2xyZTlslylI1rstUNSGWr5KzE0y/m+3s01HHemlYjkQNjY/0Avai3vXto3d638SW9hs8M7caCumFMgvWNvWGREUJWf5oDJSPvfDuGc/b5qSDp+T5Yge+vz0qWpSufgLfmC360KCQPaayFRuCfm0ldhLPbmyH+d8WoG27G7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjiR8ABk; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjiR8ABk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10e86e52so378561cf.1
        for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 20:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786765253; cv=none;
        d=google.com; s=arc-20260327;
        b=eAA0bz21ChQKRuwItACLjmuVKGMWT+RN1t7a22yExgRrXeg68d5OdLpVHnitcPRbF/
         0JfCrsu/UmN250YS9t3v7gPpVGsOR8jR0G03LIbVDMber00Ifk6ggeD+9zyYcih0+Los
         IRHvUH9mLj+YSGdl9+oxSQXUIowqP0UoXNZxCr2RzJScm+B20m9gv6JEZbh7mCfED7bD
         l7m9+B5xqyu0T289DFGR1DZCpnJkPItqomQspEzr92aKmtcb5I6k+/iy/aJXJyBz50kM
         Bp5f6FIMrHxn1oBqWobwZh5F5qKNe0g/gNobPoBCofEX6w0eyQsQQEHcgy1MdO+zWWOI
         GVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vkBjXZgfE9QuZPVA0q0zgHjLQlsV7v8f9ZdsGtdUY+w=;
        fh=vL0950MGBEqfd8or3sDA75XNb/RweubOPlmoPYyg8hc=;
        b=lTzr1UXfEAxLaazdHws6qgq6o+SY4UGE57DQTibOPXUs01/DoD6zLs8fg3VTW9REFI
         L5eorNiVbpNW68coIwnuWXQAjlesyK5lVadZwJte/9KbVtPUj8dfBpLJdQOzX2+95yOz
         kHq8cMzSp1ZppTRtaEXazp6LbSz3WNFiJnPcGjtiYmapNsWB/GeLAylQXWfxQAFcG5D5
         Fo0sZugxrfBdmZweQwNrtc4lnyKg1TXvrawwcdEUPyGzRNmueExUC0MG590HBBfhUXEs
         EW0Wk4qtLbqcqrmV+3oBjvZcGZQ7YgqieU8WoWmE3Xyn14kBuPiwvdwVObheoeGgdZTc
         s0ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786765253; x=1787370053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vkBjXZgfE9QuZPVA0q0zgHjLQlsV7v8f9ZdsGtdUY+w=;
        b=tjiR8ABkpdqUfdhGVjqvPqF6OksfiK5cjhALxzvPR22FDSbBCMt2cGIg+5ARAmZARK
         glamKyG8qHI82fo09so2n8EJJb+BFJ/Ub29HXA+LhNVA7eucVsLQiKhAwshh8Ion6q9/
         8pJSTXfx8DhnYJyKw5VwnJdCzzdQkn8Zr0KG5K4JmHLO9KXBKGTHx6P0fT/4+HxPmBii
         RFm1tLJlu7QcazGd+ic/xURAOOCE0K+xilMXjIPcFKwcwG8pr2pP5zxbUFivN5ISNRo1
         HnHchcYOO7qNXtPDZEwiw2C8uF9lew3vf458s14nz4YaG1z+oqhp8bXKwDgfbiOCrJYm
         QAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786765253; x=1787370053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkBjXZgfE9QuZPVA0q0zgHjLQlsV7v8f9ZdsGtdUY+w=;
        b=DGqI15lW21k/CNuy3ORdiHHzbOxrDBkztjP5JEwlv+dlngJpwvk9qXhLIiJP9yJBjw
         O8XXUu/3jn5OfYfEKYjZUx1qJzgme+ybX6YhiWM/mrVKvUWtC/5IpnDfxL5+Oa0jsQ3d
         w99nrzgg/XmDd+tgDG7kuJbq4T7fiTf+aHwyR09E3/NsTFH8fS8kFjTkGYp+5PKZ+5/x
         1pnxCczcE6l7VmkZTNL4V/S4F2afzAecWTGnGvzjBZHllOUcTUIeVXcndv3Jz3+dhvok
         uaJU7VGoYhiqROwEYJoQpOM98hlwp8jt3BIlScZxpo0KsCzKrD6U2rIZJDAg8M+FHbS2
         JiFA==
X-Forwarded-Encrypted: i=1; AHgh+Ro99PNLRpoZulzTEoMOE0X3SjtgbQATjo57iPBL/cqcvrtce5/GNnXWR5tBFU+GrMDuiLSMInV8LL2jFANK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdc0K4L+Pfhnv2AFOWB1mHYkLb1drzbu1XkzmxYSFt9kUL14Un
	vzZP3lHMEZ+zB3bq+wIf/xU3Ot4YHsvEF3tMjP7fVY7eaZiLb6ybKj1pcYTctg6L25T5AfatbWC
	aAomEU4geffm+KDdJyKi5Y6ewCgp6gzxP4nW3v0zE
X-Gm-Gg: AR+sD13AarAb5BeNBVO7YVgmftVYbppjQYgcoOn5n4SNg0/fCHH1IkUv/vxW0a/oKlU
	BTHVJOZHW0Hy0NSaTSgSirR8yF4uLGltfCz3v0SuV1tt6Mx/vMM5AcCA6RyL+Pcr3XlURAD5fBW
	tyWbNffOD60KObjTsnxgAmbc2acNaTwmECObO8RKhcqLrjbKpN1S1FiielXKfx6zxmfTya6HkIj
	VDGYqoOj9oi1pQnnSXFA8VH0AdYD+S3T5wl+Rxw3yxvEpTjP3dCYEqQGDxsPnhsqWRZzlSjqa5y
	IKWcDXJO4z97KsHbd0onShKelGBbsSuhB6GYFoZ6gM+YxN3B1gq2iw==
X-Received: by 2002:a05:622a:2309:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52d863056ebmr33346621cf.13.1786765252641; Fri, 14 Aug 2026
 20:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-2-hao.ge@linux.dev>
In-Reply-To: <20260812054105.102637-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 20:40:41 -0700
X-Gm-Features: AcwNN1VIChM5uS8AeDFgxDsAxr3cLyAQ5ichFcFG4fV7s7-Mxs0cUi0jsKmDMp0
Message-ID: <CAJuCfpHYnjhHh6mex5vuzwz=ggn8cuW_oR03KWih9vx+76a+RQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] alloc_tag: move release_module_tags() above reserve_module_tags()
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:41=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> release_module_tags() is a cleanup helper. reserve_module_tags() can
> also fail after storing the reservation in the maple tree, in which
> case it should call release_module_tags() to undo it. Move the helper
> above reserve_module_tags() so no forward declaration is needed.
>
> No functional change.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/alloc_tag.c | 92 +++++++++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 52aece27b00e..af44f90379f2 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -835,6 +835,52 @@ static int vm_module_tags_populate(void)
>         return 0;
>  }
>
> +static void release_module_tags(struct module *mod, bool used)
> +{
> +       MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
> +       struct alloc_tag *start_tag;
> +       struct alloc_tag *end_tag;
> +       struct module *val;
> +
> +       mas_lock(&mas);
> +       mas_for_each_rev(&mas, val, 0)
> +               if (val =3D=3D mod)
> +                       break;
> +
> +       if (!val) /* module not found */
> +               goto out;
> +
> +       if (!used)
> +               goto release_area;
> +
> +       start_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.i=
ndex);
> +       end_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.las=
t);
> +       if (!clean_unused_counters(start_tag, end_tag)) {
> +               struct alloc_tag *tag;
> +
> +               for (tag =3D start_tag; tag <=3D end_tag; tag++) {
> +                       struct alloc_tag_counters counter;
> +
> +                       if (!tag->counters)
> +                               continue;
> +
> +                       counter =3D alloc_tag_read(tag);
> +                       pr_info("%s:%u module %s func:%s has %llu allocat=
ed at module unload\n",
> +                               tag->ct.filename, tag->ct.lineno, tag->ct=
.modname,
> +                               tag->ct.function, counter.bytes);
> +               }
> +       } else {
> +               used =3D false;
> +       }
> +release_area:
> +       mas_store(&mas, used ? &unloaded_mod : NULL);
> +       val =3D mas_prev_range(&mas, 0);
> +       if (val =3D=3D &prepend_mod)
> +               mas_store(&mas, NULL);
> +out:
> +       mas_unlock(&mas);
> +}
> +
>  static void *reserve_module_tags(struct module *mod, unsigned long size,
>                                  unsigned int prepend, unsigned long alig=
n)
>  {
> @@ -922,52 +968,6 @@ static void *reserve_module_tags(struct module *mod,=
 unsigned long size,
>         return (struct alloc_tag *)(module_tags.start_addr + offset);
>  }
>
> -static void release_module_tags(struct module *mod, bool used)
> -{
> -       MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
> -       struct alloc_tag *start_tag;
> -       struct alloc_tag *end_tag;
> -       struct module *val;
> -
> -       mas_lock(&mas);
> -       mas_for_each_rev(&mas, val, 0)
> -               if (val =3D=3D mod)
> -                       break;
> -
> -       if (!val) /* module not found */
> -               goto out;
> -
> -       if (!used)
> -               goto release_area;
> -
> -       start_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.i=
ndex);
> -       end_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.las=
t);
> -       if (!clean_unused_counters(start_tag, end_tag)) {
> -               struct alloc_tag *tag;
> -
> -               for (tag =3D start_tag; tag <=3D end_tag; tag++) {
> -                       struct alloc_tag_counters counter;
> -
> -                       if (!tag->counters)
> -                               continue;
> -
> -                       counter =3D alloc_tag_read(tag);
> -                       pr_info("%s:%u module %s func:%s has %llu allocat=
ed at module unload\n",
> -                               tag->ct.filename, tag->ct.lineno, tag->ct=
.modname,
> -                               tag->ct.function, counter.bytes);
> -               }
> -       } else {
> -               used =3D false;
> -       }
> -release_area:
> -       mas_store(&mas, used ? &unloaded_mod : NULL);
> -       val =3D mas_prev_range(&mas, 0);
> -       if (val =3D=3D &prepend_mod)
> -               mas_store(&mas, NULL);
> -out:
> -       mas_unlock(&mas);
> -}
> -
>  static int load_module(struct module *mod, struct codetag *start, struct=
 codetag *stop)
>  {
>         /* Allocate module alloc_tag percpu counters */
> --
> 2.25.1
>
