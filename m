Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485729;
	b=i14munP482PKVcgTGtfyQ9TIG67oMjG0GIfw0aoQdODPnrlpTplZsko0NsxzH3FaQvlY
	 I5wHR9XUZEZlUQxg2teN0CjC0w8rdqIFxhr2xuqpLRhj8LjFRCWXRgHauPWGbvsbFR9En
	 6onetN8kiofS+hB6DP+qprCqZroeRBX+kNYVbAketfJt6pRkqddCqz7SjcNuXtpZTj+U9
	 rRymqMzkQJe91PvO45cvES0O2sumPE0j71k6ZDIYy1Spy6eHuVA8JX5kb/1ARvu6SjrZR
	 CvGTTy+ZfMjtTQmXaqIbtcWNQ19uaCdqTMFPxejlqa5SmmtosJA9WNn6kMSPw0gQY8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0oAQige8Qi/rgMVB+Bcnts0omvPc1rRAyqyWh8s/v8M=;
	b=ytl5dWzvIHvQxRUH/wQ0jFHpSs0RrgMoh8GID1/0GUc9bAuV5MWmV0URTpAmvpMHBAA+
	 Q0J09Va0AyVquikI47T7AzhgUTu/Uq1hjKGBxnoo8jmOxmzcs3x3FLBjHw0i+zEXSEUCF
	 hc24n/fyTnQSk39vH8RcZy58Oq2SH5L3m0QQD+8DrHZ02DEg1YSwUKJ4IeuBkS0BrQGYA
	 jQQKeTCsR/YrALUDZfQyzmKKea7ZPCJEcqf6C+h1vHfMywJWCqRrl2FSQj9iy4XALEYnU
	 VVDiuJ5RIVHInVySENR1hBfY4TxRqnciCoEhelF7tdBM0FBz/LqeHNdLOasB04nPOLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fHx7NtAt;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B6606A31C
	for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D8B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fHx7NtAt
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so26112015e9.2
        for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 04:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794485727; x=1795090527; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oAQige8Qi/rgMVB+Bcnts0omvPc1rRAyqyWh8s/v8M=;
        b=fHx7NtAtHWvLUnhuF+i8gi1BVSUFdl7Rx0BLSLZny3JUMgRnVIxWo4fLTUlb6qH9V5
         Krg9XigaFNHvxqvcF1NZcPTAwnqT62zkaoIWIBgf4eHtvpaz/js4UwviRpr/EhHwzW55
         eNg6Yv6OcTj5Bc48pj7KRWtyvp+1e480q/G3iNkR8mwSyHtupc2SbCCkp6nDpf0WvddN
         JBIXdXB6cTe0Lp8rDRdxV6xR01pZ/7nqd7voB0BH4UGkcrZ3+g+Oc+otUiS/XWCMklR9
         S59h+buTV4hVvk6OmSumIb7GQeBzisnvLfnOpRK6ptBfXduArLHw2m0Jx54ggiE4EEXV
         lbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485727; x=1795090527;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oAQige8Qi/rgMVB+Bcnts0omvPc1rRAyqyWh8s/v8M=;
        b=0K5/s2wjBiyQpnPQiN1pOo6aB1uOMA/halBsphLnU2XOVpxeguF3n4i5C5iZVG8SHv
         oDiMMuZfFFNQHwKF+Dm3a0VSw7RKDZj7Xi5YFhUxn9qC8/UoaY+fjGOvRXa4LbWnGPpI
         1ULrupLpmkLn9ZO61avSS3aYt/Nu/15gjCiVAQ0H1mCZTbDyP5srmZLBI6mlV79yHWIX
         sc1ncwMtfqmVIVCCXJRD18Hfu7s5EDCN/547733udEwkrXhK7rZm0k8V1W2KNYjA0zUg
         LyhL93IXdhAR6ALUsvOFsxfmKqPxHexaHOJvRapFPqa9YDysZuNilXCmPUrEv+lpF6bN
         8icw==
X-Forwarded-Encrypted: i=1; AL+hErE8DTeXoeQZ5QhRsxyP/GEHXJJYY0bEebm6x6gHJkpXuJdjEXcnPo+SIDH4RLwDm9VLFzgYYWkmcyJMMxao@vger.kernel.org
X-Gm-Message-State: APuU4Z9KoMbTZMo4gFgqsTD6/tXSfn4RXkn3zCxXxymp11ArtgQFIGbz
	szHyoMWHOsrWZ6lUmgFj6S74Ofu4/lDXdSgdEPqtZs9cjlxWRCUBytbW3CqwyB1HWG07Zfhdmcp
	6sf0bN5JI/F4zWg==
X-Received: from wrxp2.prod.google.com ([2002:a05:6000:182:b0:48d:ed12:7c4c])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c7:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4ba09321cd4mr94371755e9.2.1794485726822;
 Thu, 12 Nov 2026 04:15:26 -0800 (PST)
Date: Thu, 12 Nov 2026 12:15:12 +0000
In-Reply-To: <20261112121512.1670347-1-gprocida@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112121512.1670347-1-gprocida@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112121512.1670347-5-gprocida@google.com>
Subject: [PATCH v5 4/4] scripts/sbom: update rust export macro in nm parser test
From: Giuliano Procida <gprocida@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the sample `rust/Makefile` export generation command in `test_nm`
to match the conversion from `EXPORT_SYMBOL_RUST_GPL(%s);` to
`EXPORT_SYMBOL_GPL(%s)`.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py b/scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py
index 93787a1cd156..4f7ee1142cd8 100644
--- a/scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py
+++ b/scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py
@@ -214,7 +214,7 @@ class TestSavedCmdParser(unittest.TestCase):
 
     # nm command tests
     def test_nm(self):
-        cmd = """llvm-nm -p --defined-only rust/core.o | awk '$$2~/(T|R|D|B)/ && $$3!~/__(pfx|cfi|odr_asan)/ { printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3 }' > rust/exports_core_generated.h"""
+        cmd = """llvm-nm -p --defined-only rust/core.o | awk '$$2~/(T|R|D|B)/ && $$3!~/__(pfx|cfi|odr_asan)/ { printf "EXPORT_SYMBOL_GPL(%s)\n",$$3 }' > rust/exports_core_generated.h"""
         expected = "rust/core.o"
         self._assert_parsing(cmd, expected)
 
-- 
2.56.0.567.gdb80ae8cd5-goog

