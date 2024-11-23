Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3B17A5A4
	for <linux-modules@vger.kernel.org>; Sat, 23 Nov 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732329747; cv=none; b=NswZH2yZI8ukH/etuut0ttkC6gyJUM2SjGvwtps3iXRhhMY0guF1h8X1EXFYRyKokYcdUanuznCmemdW0Ao7imCE+jpZyEGX7s4rXtqPNFhIvuKuyRGbPtslD0MVoc/k1oQKWfVG3WOaDTn22OR8w0WjcCgAW7Ag7WO8fiCDnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732329747; c=relaxed/simple;
	bh=C2iRNRCBIbNngHVZfY3T3X2W51MTV200R2LoLraROFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMgkz8iR0H8i92yj4YsOh58EdJTL2ui+HgILpteFcazwYiRFLyp8X69O5WfXKrIjwzkmEDiyjeLtmAqtw8S20XX7KaNje13KjVzhVDDJLuSuvuW+R3ic0/QVQvXtIwLl5xZ0FcfOLbgCVN02W8tuaW66uVQDueIFjXPSnya4lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Se1142Ld; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Se1142Ld"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee57ae0f61so46092697b3.0
        for <linux-modules@vger.kernel.org>; Fri, 22 Nov 2024 18:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732329744; x=1732934544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kii4UoP5f1YtphOdoxMErS859kUztR72G7iPiVSrt7I=;
        b=Se1142LdPRwWorcAjCE4jKISf4oVIoqHSFrAeI9qXs+iQptUWwxEtlZ+Z75GHOyurF
         VheeGTHDMzRdVGBvrkpMg0gbW46jU3YX+dDlqu3Tvs0wsB1t1gVc/Nd5kEPDpqucqiTh
         xdys6qAbrnaPHQ34OAXDaDlM3tT1LA5XQUOR3vzXKpdo419gASi9GVtjgmKS0Yk2TK0u
         ihDr5KgXEZpXbJI/MCn664gvIjHyEbEaypnmbi8buG2qKrC9+1fWrR+B3mufjhTiCR14
         lov5swBhcmCEqXwWnqxkioCuSCjN3mP2/4InGf9gLwhNgOxF91m95hq591oztV/JDN9C
         QZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732329744; x=1732934544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kii4UoP5f1YtphOdoxMErS859kUztR72G7iPiVSrt7I=;
        b=hB97EEe0heHG4Ww6zJV8Hq8FZNZk3tCEOc2dSS/S6artRinfw/hKN4YhJreJZTFk74
         2f2AJ8vmSZQTMSdmvkL2a/nHcfuoTenyv3bNxfbTVaoQ+KB/qdaNQhj/pfV8nO7SaQw4
         skOLP+u5PhB4mri7TR0hiDOw4ldSvMtSPLZm26QYst9SRg4QVSyAXeyfyQqg8uDR7W7N
         CsCYF175KOtb7r4XFfa/8bdBMXakQa9gOMCMH5IUnp2+tlffUw+9rdXfVtpBMg5JCswA
         d/7TDyTif6PFU0byhkeWAT93DobYwqev47kfVG8LpnB5+HTaTOWF/l8K66F8PAipHF+8
         tItg==
X-Forwarded-Encrypted: i=1; AJvYcCW2SU6ovgT4HAYA5IOe1kENfpcvo1/rD9JdKNEYuXCrirHRYZmYZJW1CSRbq9k4nr7lO68ggLPl7cq7SCtq@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOS8EO1lwCrhlprQ8DxCSINI+SWVzxCFca1LSF5dRd9rOe8zt
	0HhlSRNZE+rVPIxsYkraC+kbz11o5uOznF0N7tvwHFXEBqURdi/wu51sqtqJ+iG/Daq+PSy+dg8
	tY3vF3A==
X-Google-Smtp-Source: AGHT+IG+H4NW7tyyIrvwq7W3DAn+ppP0DFvvL1CqE8PbvAp+Z5WdI4+9TjnoY/n2Aojqm2QXy8sSu+gLuVEg
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:988:b0:6e2:1b8c:39bf with SMTP id
 00721157ae682-6eee0874b31mr48797b3.2.1732329743988; Fri, 22 Nov 2024 18:42:23
 -0800 (PST)
Date: Sat, 23 Nov 2024 02:42:18 +0000
In-Reply-To: <20241123-extended-modversions-v10-0-0fa754ffdee3@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241123-extended-modversions-v10-0-0fa754ffdee3@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241123-extended-modversions-v10-4-0fa754ffdee3@google.com>
Subject: [PATCH v10 4/5] Documentation/kbuild: Document storage of symbol information
From: Matthew Maurer <mmaurer@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Document where exported and imported symbols are kept, format options,
and limitations.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 Documentation/kbuild/modules.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index 101de236cd0c9abe1f5684d80063ff3f9a7fc673..c32e3ed67cd26070f6929f6ad98c4308a1ab71f8 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -423,6 +423,26 @@ Symbols From the Kernel (vmlinux + modules)
 	1) It lists all exported symbols from vmlinux and all modules.
 	2) It lists the CRC if CONFIG_MODVERSIONS is enabled.
 
+Version Information Formats
+---------------------------
+
+	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
+	sections. Symbol names and namespaces are stored in __kstrtab and
+	__kstrtabns respectively, using a format similar to the string table
+	used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs corresponding
+	to exported symbols will be added to the __kcrctab or __kcrctab_gpl.
+
+	If CONFIG_BASIC_MODVERSIONS is enabled (default with
+	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
+	CRC stored in the __versions section of the importing module. This
+	mode only supports symbols of length up to 64 bytes.
+
+	If CONFIG_EXTENDED_MODVERSIONS is enabled (required to enable both
+	CONFIG_MODVERSIONS and CONFIG_RUST at the same time), imported symbols
+	will have their symbol name recorded in the __version_ext_names
+	section as a series of concatenated, null-terminated strings. CRCs for
+	these symbols will be recorded in the __version_ext_crcs section.
+
 Symbols and External Modules
 ----------------------------
 

-- 
2.47.0.371.ga323438b13-goog

