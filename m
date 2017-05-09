Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,  linux-modules <linux-modules@vger.kernel.org>,
    Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH RFC 0/3] depmod: implement external directories support
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
	<xunyshmagsw1.fsf@redhat.com>
	<CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
Date: Tue, 09 May 2017 11:50:12 +0300
In-Reply-To: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	(Lucas De Marchi's message of "Tue, 9 May 2017 00:51:43 -0700")
Message-ID: <xunyo9v2ct2z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 9 May 2017 00:51:43 -0700, Lucas De Marchi  wrote:

 > On Sat, Mar 18, 2017 at 2:46 PM, Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> Hi, Lucas!
 >> 
 >> Any feedback on that?

 > I gave it a quick look and it looks good to me. I applied the second patch.

 > For first patch would be good to use scratchbuf

Ok.

 > For this one... I miss some tests in the testsuite to be confident
 > this a) is working as expected
 > and b) isn't break the current behavior.

Thanks a lot! I'll think about the testsuite.

-- 
WBR,
Yauheni Kaliuta
