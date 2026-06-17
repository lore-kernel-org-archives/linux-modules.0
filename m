Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1B392C56
	for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687600; cv=none; b=EZYAqeliTxhB1ylzQvh2W3ITBOcAY+KaxytjhfS5eQq/yczP1jPxS/yp46ON/AWNxX9KbI2mF/l3xp5n26KjRAgZAhCbAyC0RlvLlrAC8yn5rTY6WSpsPMEnJL3Z69HwuI8g3TG5GWOKnf82GAp0LxdyWljdadSiuV9CNy1uUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687600; c=relaxed/simple;
	bh=VNb8Oeo8fsnl2dNubUFSWKcRBi3wEZOagsaNZh7wB14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZTcp6dctxPVS8jys/jl+5wwvnSaExQ+SqEQVxf4uNmZbiC82Lw5TjCZCrdH9wP5IZXrrwps0wAmtRRmh7SO/f9tkmpL5tKtFA81hecEXQf+WuCYLHqLCg+ADPNxbHw7hn6MqQjaI1WKu0GCacRNkhZz6J8v51FfvXt9Qr9b+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXPlLkEF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXPlLkEF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso6845915e9.0
        for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687597; x=1782292397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdzEnJF2ilqo5mGBwtUC4XQR13hh+SJ7AGP/8bu8ACk=;
        b=CXPlLkEF+mjs8vpLhTWd+Sc6t6QohlDW0zR+1qcMjm4Su3Jd32HU2gmk3tPPTWwaNP
         p9ssRghKH/qE8kop/lDoIOGRnrReIUl1o2il41jH0H49gm4lnXzQzLptSBCUj5j9fKQv
         EU+PWayJVz916sv4cYsraFktqAZx98W+EwtlHyw24vzczbsTM+LAoMcoHaSVW++876zX
         P3iJ/62XtmEQ8fnKOLJvA6DPlQK+v2XT3snuEaU3mmisnQLKl5Q3dwRQBaDaX8slWqWS
         RsyYUdHifQo7y0YeDmzP4nB0vvmJlfur2CQGxUonbu7xpZLhA88JF1/R/TwQYSve1V/l
         ECxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687597; x=1782292397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdzEnJF2ilqo5mGBwtUC4XQR13hh+SJ7AGP/8bu8ACk=;
        b=CXQ2xjfuqIf9/iXebhg/oT5BHkLFwmXxWPPOhA52HRt9CNAQp0QjEU0O1hITJRtEna
         ek57fsq1Fo6Hfdwvf58inbRiw0t1/9r1oDO7lkXt6iwidVB2suT99O1NOAVWBqH+pX4I
         otV3ZluAtPXXkCkMHe0v4YTY1F54sJFJYKrEV9TbLyOYRk2sXcnCOqdBOZGdRgGlAY/v
         021HVHUAllTw2L4g/0H1oCg0s28/txCTcTd9b0xL4LTftv8Oul7m4Pt2lBjzRXFOlI/P
         MI1Ce5kfjCFg29uo4gul3Sco6WI49f47n2Kxx7m1zd05attoVO0wjFFLDYCJRnzmvobI
         XJ0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8voykC0AE5Px3wt8Hli3gKTEkENlZyArh1a+3wwID0DbJeZaE8QfO7BJXVdnY4O0VkW82YOB6jWjKDlU55@vger.kernel.org
X-Gm-Message-State: AOJu0YxAT4kch9eGqFOjan6+tWsBiLB8mMQoaOxuVNSDZh4qVRW2P8sQ
	WR9C5ShLPCanOjflEWREfNR+hyV2i+XiU/YbXqv4to0fMuNYYV0aslgC
X-Gm-Gg: Acq92OFf2kR3ILJlolJXPkUNkLy6OhgFBLjt8fHdYYw5oltZMKWYXcm/gHh0WEhRtq+
	Kvc7gR0xEPNrBVBDXE3/3jnwkTjhiu88f8JjqQf5fxgy/z18S/YV1z7+kJmlKAjFzeQ18QDLDYF
	mnBooRp4Zb9hfn75ZnOZx/6+ww+9ar1aufcs3Dpyap2RL7Zlxwy2qjN3Up1gOx8em5S23HN0wvj
	CE1/MhM16oIfkJLXZIeWkv0UhGHP7nmiBQRHdp0XfcZayVFWs80et8Qny+usJxNNtrev1cpFPgJ
	Jo/HVkv0iB3G5zkVVb+P8l87w86cfHtCKIqdBiTdAKASnupCgnUp881cFXnRIqq+tmpU7Li2NRR
	T6S8Cel2FBbv9KAw5ZoTG+9PrKp33aII/dYNZFHdqZ2BvJH/5A4+HrEKz5xXBDO1kFyuJ/t43F3
	dzVUOgfx9zeZPICqj6qC50KtWI2BbM6DFOtVNhqfusDyICpjex+KQk
X-Received: by 2002:a05:600c:5290:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-492340c604emr29094785e9.7.1781687596953;
        Wed, 17 Jun 2026 02:13:16 -0700 (PDT)
Received: from [172.16.16.38] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a0e9e4sm130471915e9.0.2026.06.17.02.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:13:16 -0700 (PDT)
Message-ID: <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
Date: Wed, 17 Jun 2026 11:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs
 attributes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
 <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
Content-Language: en-US, en-AU
From: Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/13/26 12:41 PM, Miguel Ojeda wrote:
> Hi Malte,
>
> Some quick notes...
>
> On Fri, Jun 12, 2026 at 3:29 PM Malte Wechter <maltewechter@gmail.com> wrote:
>> +/// ```ignore
> Empty /// before examples.
>
>> +///     // This will extract "foo: <field>" into a variable named "foo".
> ` instead of "
>
> i.e. please use Markdown
>
>> +///```
> Missing space indentation
>
>> +/// Expands the following output:
>> +///    let item_type = {
> Missing example block, both at the beginning and the end.
>
> Please double-check by generating the docs and looking at how they
> appear in the browser.
>
> The prefix of the title should likely be `rust: configfs:`.
>
> Thanks!
>
> Cheers,
> Miguel
As of now doc strings are not generated for private items in the macros 
crate. I am moving the `parse_ordered_fields!` macro into 
macros/helpers.rs but this means the doc strings are not generated for 
the macro anymore. The `parse_ordered_fields!` macro is a larger helper 
function, and the doc strings are relevant and helpful for macro 
developers that wants to use it.

You can enable documenting private items:

diff --git a/rust/Makefile b/rust/Makefile
index b361bfedfdf0..b4239443307e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -147,6 +147,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
      OBJTREE=$(abspath $(objtree)) \
      $(RUSTDOC) $(filter-out $(skip_flags) --remap-path-scope=%,$(if 
$(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
          $(rustc_target_flags) -L$(objtree)/$(obj) \
+        --document-private-items \
          -Zunstable-options --generate-link-to-definition \
          --output $(rustdoc_output) \
          --crate-name $(subst rustdoc-,,$@) \

But this enables _all_ private items to get rendered, which is not 
ideal. How should i proceed?
Best regards,

Malte


