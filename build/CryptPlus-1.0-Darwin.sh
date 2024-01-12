#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the CryptPlus-1.0-Darwin subdirectory
  --exclude-subdir  exclude the CryptPlus-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "CryptPlus Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
OpenSSL is available under version 2 of the Apache License, given below:

-------------------

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions.

"License" shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document.

"Licensor" shall mean the copyright owner or entity authorized by the copyright owner that is granting the License.

"Legal Entity" shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, "control" means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity.

"You" (or "Your") shall mean an individual or Legal Entity exercising permissions granted by this License.

"Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.

"Object" form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.

"Work" shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below).

"Derivative Works" shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof.

"Contribution" shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, "submitted" means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as "Not a Contribution."

"Contributor" shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.

4. Redistribution. You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:

You must give any other recipients of the Work or Derivative Works a copy of this License; and
You must cause any modified files to carry prominent notices stating that You changed the files; and
You must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form of the Work, excluding those notices that do not pertain to any part of the Derivative Works; and
If the Work includes a "NOTICE" text file as part of its distribution, then any Derivative Works that You distribute must include a readable copy of the attribution notices contained within such NOTICE file, excluding those notices that do not pertain to any part of the Derivative Works, in at least one of the following places: within a NOTICE text file distributed as part of the Derivative Works; within the Source form or documentation, if provided along with the Derivative Works; or, within a display generated by the Derivative Works, if and wherever such third-party notices normally appear. The contents of the NOTICE file are for informational purposes only and do not modify the License. You may add Your own attribution notices within Derivative Works that You distribute, alongside or as an addendum to the NOTICE text from the Work, provided that such additional attribution notices cannot be construed as modifying the License.
You may add Your own copyright statement to Your modifications and may provide additional or different license terms and conditions for use, reproduction, or distribution of Your modifications, or for any such Derivative Works as a whole, provided Your use, reproduction, and distribution of the Work otherwise complies with the conditions stated in this License.

5. Submission of Contributions. Unless You explicitly state otherwise, any Contribution intentionally submitted for inclusion in the Work by You to the Licensor shall be under the terms and conditions of this License, without any additional terms or conditions. Notwithstanding the above, nothing herein shall supersede or modify the terms of any separate license agreement you may have executed with Licensor regarding such Contributions.

6. Trademarks. This License does not grant permission to use the trade names, trademarks, service marks, or product names of the Licensor, except as required for reasonable and customary use in describing the origin of the Work and reproducing the content of the NOTICE file.

7. Disclaimer of Warranty. Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.

8. Limitation of Liability. In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall any Contributor be liable to You for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this License or out of the use or inability to use the Work (including but not limited to damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses), even if such Contributor has been advised of the possibility of such damages.

9. Accepting Warranty or Additional Liability. While redistributing the Work or Derivative Works thereof, You may choose to offer, and charge a fee for, acceptance of support, warranty, indemnity, or other liability obligations and/or rights consistent with this License. However, in accepting such obligations, You may act only on Your own behalf and on Your sole responsibility, not on behalf of any other Contributor, and only if You agree to indemnify, defend, and hold each Contributor harmless for any liability incurred by, or claims asserted against, such Contributor by reason of your accepting any such warranty or additional liability.

END OF TERMS AND CONDITIONS

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the CryptPlus will be installed in:"
    echo "  \"${toplevel}/CryptPlus-1.0-Darwin\""
    echo "Do you want to include the subdirectory CryptPlus-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/CryptPlus-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +205 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the CryptPlus-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� p��e �}`\E���<���Z(�K(%)m��wK��ɶ	}-I�C��fs��lv�}��	�b�X�
ZE4��i?E���g@���FD����1*jE��sf����lڴ�ߝ���o�̙3gfΜ�;s�5Z.g�t:�**D�Wr�YZ�}r�����YVꬨt�NW���%�Ǜ1t�X�V���p0�-E��A���t�I�]�Z����ֺ��H�L�Jڶ��<R�Ty�R�����J���ʪRAtN-��?����ޙ.�l�{\��*���������:����}U��^k����y�qi[\�f�Wp�ZT����������1[z�a�v���޴d���+m�K��7�k5��{=���T�%�;���G�������g�⌴��Dhk ��������_Y*N���^F�����[�ic3��Kj�7�l�P�,}GXS���d��^�^q(m���y0b�ˀ�|q>�|q��/3�<��et�W���q�:w}c�i�����*RxB7�j��k�_��^���
�b)#�7�!4��u�4#g:�o�]+��rA�a��:]�p�A��S�w��!�k~�#?8~�οT�aoS��o����D�L��`�\�7����%o/��-py"-�4x.OĢ˃a�/�<��%�b�`MJ/?J'\R��8�t�\p:���K\�`�F��qqu�1~��X\�*Y����Ŀ�� B��	��3.�2.�2.�2.�2.�2.�2.�2.�2.�2.�2���mn��mÎ�
�z7��7����/�BCߣ����v<^p�����5��9,?p��%F��y_b���f���r-R����#�ĸ|_�n;���snV���.h�� l�k��"Xş,}�<���7�!|��7���5+�G~�$����I>_����+C�[���,���!�ȹ;��'�O����ɨ�g_C�6(�E�w��#y8,߇��{�5��XC�����G���݃��pC���lǶ<!�5�dOŚk��9 ̡���MZ�E~!��Ѿц�r���C�!�E��Q������߳O�f���N���~�~^�S[d�V=Lr��`(�q(�r��{r��,k5��B#��ӹ�!��f� ����߉M�{�����3ڰg�����P/9V���8��t���,�}$\����,_�C��AH�5�6�RE9*�~yR4$�}��٣�\������_�/�K9Mؿ�/����z�g��8}�ejc{y���'kc{Y9x��:A�{H^˫s�ڛ<��J>�4�hl{󰩱��j&�ytCE&#rܣJhD~�chlc}�u�X�/x��a�m�<�-�ݘ��cѿ���o��?��䂽Z'�_`�%vA^{uI!oU/��mP��M&�^x���5@��O{��E(�� �c��c���Ht�HRo2I�Ϋ����W�V�7,WnR�7,ߺ� ��}���g`Q�u>�������^� +M�A������ۗh)��I������z�<A��Y4���v����9���9(dm����@�������6���.�ޠeۻ�Jj_��Ҷ���mϳѪ�g���ߨJ�W�ހ����>��ڟ���/�,�|�IFf�K#H�!��P�k�h,��m������%�ͣa�b<��IC��<9�"FP����Jn8:w ��W&��F2&?�T��C���"��f�{�������	�B�#���;���Ӧ��K�<����%I' ��2ѯ�V�囥�G�bY�Y��E9ߒ�}{���ut��]fQ\��L~7�=��ڭN,��n/��M$'/���f-��''�z:����Z�i�Mh�+�����9���g5y6�U�?�5�哓����h*��q�
"&M���>x���Cs�/���쀉�� �na�c�V4)�1�5���g��5���/U�h+�Y�8�>0��N��>��JXT(��L ch��{A�Q_Z��t�PG+DV����C!��=c���0�����h�E�
���<
����r�4jl��5�q<U̵]��>.�1�rD����|�����~6�Uf�@���z�2S��{6�|���WޖǛ�<n���GN) ���A��`L��2����:(?���9�0nZr=+C8p��\�;g��Skh(W����P9�bl�'�{zC�6�a��y-���?<.K���r+���B���
9q�vP.]�Z��q��;,`��;�>y����0��f䰌ƹ(9k�5r�c�|6<R��~���C*)1�<��ds��P��$2Ȧw}h}���mp`�BG�,��l����zn�C�ͽh��v'8���� �ܶ��0�dmeZ�F�|�W�&��1\v�h]�1�F��OZ``��C=�3*W����-�\7U�b��ҿ#�1>U��T�l��:ޠ��#G��[�~�~\�/�U�f �k��n�kQ!�X���]P[C�*�<����>��.��v􌃝:G��ÇbMU���L���Y�ޅg��G�o�ϒma!,�0o������Je2�o��A����E$|�{(��<��gYru`G�0��.{��x�@�����T�����yZ>C���V��bXv��*��܇�o���}�{j�C�j��@�����|�jxr'<�X��ʻVcڵs$��J�
���	v�V$cL$�9R��tm�bk�;�ǺF�f�j!V������=�=��)��p��3m���Kj5��,*��">�z�.�Ԙ���vP��{���G��o%��B��#J'0��o`��o����-���X�B��b>�؇ӏx�(Кd�]�J�]�?*	���Q~�����j�����
�#u}$�Oq5�/��`jY�_N3?`L7쁾��żJ&��ڥ<@^Źu�k+n��א�iJ��&_Q��$s����˖�,�4�;���ݵ=r�l�r堵w�ۻ���+�39����M��ٻ �Fه�B�?@�Ȫ���՗8��~�"�a��<J���~kjv�#�]�����[%��^�Ѥ��8�w9$�=�_�ey��h8��z�F]"�EY~��/Z�+���6�W|w���U:cҏZ~{�� �����t�S��q��k�8TX�6{��k�����=o��Ե��ޚ<����w#�:���O�9�>8���(�?��G���k>/#+�ߌ���#¡�� ��>��*T;4�l~�d>��O��i�r��>��vj��3'㧟����w��%v�+l1F�ǀ���d����'W&oO�x�M1����k���6�A��79@do%i*]b�������r6츇X��Y����k�
�&<���i��)�|9�`KR��`6U��ىF�(�9�����{Y���^�f��hj}�xÊ?�~������P���o>�V߈&y~"9��էj	�����f&�[�R;G5�dV��,�43z����'u~���v~�}�f�~������0�_�~H�8N�ƴӭ1֦iDՏ�l�Ė'0�|�#���L�~��j�x�*�,��]�_����CFCސ.���]��<5�>������M���%��v&5��p�k����x����?K{BԵmC��HC~�Am8�2�i�R��7d����|���!}X��N�#o��0�4�������s,�Խ���=Y{��?�˫�A��{���6H�}�|�C�Q�=n���A�.��d�[MWY͇����gg��/�My��S�ЋOC{m�'�����beǈ���~o��`�)��EJu!�/Ka�OC��*�����y��l�2���B�U{r&��ul�p���\36�ΗO�Vdx���C��G�):e�\���Ul����op��lx<��Bc���C	<��_���\|X�,4��َ�ç����~��@��g��{3�yw^�o����eGޏw���B�����@ؕg^_GEsj��X����P���Ѿ~�e-;�AG��.��F���Γ�|�����w���l�����uU>��p���_�`�V_��>�������_CU��h��c��,*H��wv���4�S��m�7��L�خgk�oR���j�wP��3�Y؉N�3O�����	�?>*�)����?��(t�}�����@͋�嵂n�⏵��<��9.
���x��5��N��s������A!U{��H��rj��s��ҎG4ګ�k�#�;��-����7�Ձ�2[f=]�A��N`��r�jz%���`��I�P9��l���&��0���Y�Ja/��^������I�����au������裂�O��#s�L_�^�y�T����A1/`4��B��w��$V�K�>�s603��i��ccl>��
�󠒞O>t��xu,�#V���xZ����l��(�U�j�����,aH�O4�F�Ұ��Ow���Q�?��&4�A�{�|F��'�W��<�e����}`��tq+﷦崚oߙe��4�q��M�n�O]S���^���<��֯ ɪ�y�ghzڔ�{��Fq�e	8�G���Q�B�q��}q�=��qa�OY�����G��?�3�)�ՐgX�ҷo��QedU��Ay{0�߳ A�}@��h��~7��`W��>�K]~�z���ۏs<�?����-Z��[���}[�gU�.�%f'�%%�T�c�jF/��U��O��H�sp�bְ�����&�S�w㞰û�ȼpЈ�����i�^n��v��ݫ���)/�X���\�t<�&}��o1��c�c-ɩ��L�C#�A���c��=�̻Cf���y���շG�kU�-B=c�Fb�������?�Ǣ�,`����ɗ�x��L<����v�e���*��Vt�-!����P�Y/�`�}OțsjO��|��!v�'���8Ȃ��%��
�^�+��vc�8��ɞ��˫AAZ�Z��_~���2r��1��{D�����
�+_��(/6=61f�~��ϲ������<Z��?|�/D�F��⣌7�nw9
�����~t���a�|'��Տi��r�����l�nxq�
�(�/��T�ݬ���5Œp^����lS��}|��9����	;���OɌ ��ma>���n��P9?��9����0"������?;/YTG�p�Zڝ^A""#r����5�F���<���*G���
I�~��b��ﾹ��P�'�����39�5�۽�C.1�w��[�#�����R�6��q�P> �t�,��H�Vxؿ��w��8����7��?$rN0�{�df ���9����/? ��aB��B��>w���Be/~�N�n|U�P�*Lo�v�z*'��A���$㟑k�|�ݽ���w�y�^�}����[���;h���x^���*�+�in=h�w�V��ʓ	����~a�w�(&}�a:}��g����g����W,��e?K�������黟���?T�ݏ���bѨ��-&}�ܛo���8�Z�~��ݗ3����s:�Ul�w�?��W�6軋α�w�"U�݂;�����gOR�U�m/2�W�V�]��}��l}w�������n�ٓ�w�3�����W����J��~|V*}�����]����<�Z������cW�B�>��H����|P��9ɷF��=��F�T��g
���m�d`M��e#�?`���զ�$���h/꞊�Ŭs���3$?��~f_|y��w��.�� �^:�#K�l���bU�ആ�=����5�Ȱ|�<퉛39˃�k�'�_ț7Y�;u3&��H�\� ��� F��3�����"����R�_�c��%���-���oũ糢��y��@yi��'��[K9?{U���K�2��R�4�Vy��H.�&p'j/�mH�X�R�_9��m�In��4�-��<� :�ݤC�GN�,�)�ML3NW������I������-���{���J�75�]�@�y�g*SW�}���G����~��/7�6��e�-���M�))��{��>힞^�;��V�ĵ'�@v⸥l�a��7/����屆4���X;o����<���Z�~���X��U��N>�f}^ؿ�U ZzW�$농g};㸩�Ö�
����{s��c��S��6��<Ԁi�rUfX�c��w���}7�����h�'Y'&��j�X�+��$Y@�BS��ȶ,��2X��HxDٿs)������غ�+�\��Q$�s���l�ԙ�%��Z�OQ�#���\��C���WK��|�J�Ԟj*q[�M�X�d�)K��Y3Y���T�.VHh�G�"�Q�����+����0��0�N11|�Æa�������T}O4�xbaRQ1r�loQY�ł�39�h��uVY�'�����.0��g�*K�-��7Ae�褊���A���d�M���d-���5-h���B�X�L�bmU��բXw��i������b��G��bs��r	6�b	~9�6�@*��Ja�I<F0O�]�X�b����ߵ��1�m^�U&n���OŬX��o2���nPa��ٰ�v�˿?$���|�������s��O� ��0-�����o6��?���3�n����ar�k�y�9�f�R�����H���G�X�7�O&ƕo��?�ױ~�l��<9N�؟�v~��\��*���p�u+%�,�O��O�����g�<?�ps	�<���>H/&ȷ?�8*��lٲ�1��y
G9G�����=�|�ͼ?I#�:���i|��[����(��$+c������I^��������΂'9�ye��HT�Y__``����^�R�%��dؠ��w�-GZ�;R�O��|�]�f��y�<���䛾O"=�ݟ8��Zl����4�cS^<��.�G}����;���}��m���˧������k,���\��-
�i�٪�W?p�繴��84�~=l�{@n�K\�����62Gϗ����eD~�A��eQ��Ay�\������U���8��=��6���5޾v�Ff�$��<G+�礒��sRˬy3�K�o+P�m����q�� �8�?�x��fk? Sm��H��A����<�ȷ���o���V�-Y7�E'��Ɠ"ͷf+幌��}aR���������2�D����7ⓟ
4��~p�,����~*#��uf9\Ų�E�}r��5粏��;���q�Ɛ˷y.���?�������2 ���\�|������&y��N�i~~oN�Y�!����R_B��f�x��φ=����]8�ۑ_q����Qy�̤���0���^�f�yP���3����l���Y�ϱ���Oxm�5�����k����/o��m}o��i�_��__xjr������㯺O;9����)o�~"�_ܳ�Ϝ�����K~�mK��k����TcItz���i���D�Z��46�)�m��YP3�o"�X�_��p�'�������_x��ͯ)�p���Xl�9�1�/���z|-����N%��~\ח��љ�l�o�o~M�u��|9�"�r?$�V�Mz����'��U8���q�A	�o�nw�<��"�vq��E'�{�<�'O�y.���ߘ�9�j�N���A����O�����T����a2s?4��M���0��Pۯ�����)�k;����F�G�� �� c������K�*)�?�C��W=�M7DK�~�a��e���#?���Tx�X�?z�#���� �;h� �$<���,TI��=��*�7?���ɞ{�;����*��do����1�+��Lw%q��{8���cr��s�K���<��Y�Ͼ��\ɏ�ɷ$���"(�"< geY�����Rd>8��O"K/��;��n�F>�!��N�V>�t$�xL"yƐ�|p%�F>忲��SK��;���:U�9�=x������[ؽ���ؽ��;����d��G�=��qv�f�m��v����{��&v���oa�]쾛�?�� ���og�O��^v����?����Ev��ݿ�����+�~��݇��1v�ݟ`���$�?��?d�Qv�ݟc����Av�����/������_a�W��0����o��;�p�Og�3��lvٽ����bv/b�Rv_�{��f�zv_��x�s�#������bG�8��o��\:�nv̸�!�q\����B��:V��8J).�b<���>��C�ŝ/��'|4�o8f@�a��~� \���.ǌ'X8�0ו���3�U�r,>c��ş��E�㑬��pKv��l��f��<��D����c4
r�4�'|z�g�r��>���oq�[o�p� \p�WX}�[:��&~Un���u�^>kF���"AX���W&������#�r� h�ٹ����~ܗ���\a8����5]xu�'��L�}g��3o�m�����񔷶^�^��G�s���8�i��}(�ݎ�g�	�
¥�9��;��d��qG�J��y5���v��s�n���s��Z?�u񷲅��g?�-��	��˙��\��W��_�6��i��t�����7�	Cyq��f�����3F�r8�ud���ZA�ͽVXc�g+aE�f���݂���	�)�Qs%a�T��w�(@/^�{��>� <�ȅ������܇���d]J��r��n����d3o�&�\!.���B7��a+S�xVz��YgN��Wx�u��w��]��;�c�+E�Օ� ����^�qb�q��]���b��.�m��� �n�K��bG8.��!��1�{�m�ڰ͑6_\҆�	�|A����%sJ
Ӥ��d������S�v�(�o�I��r����{���˛�(������%^���K����P�T�D7��b����d#A�}q1(�bq1��11��S�AD ,ѳN�ׅC���+WR� ���h�~�Dl��R���S�q�fL�'SF|Q_W,->�' ވ$E� "EC^,q��d�"��K�RȢTGMς�D�<��W{�Z���!9(�Q��@�C
!D�b�ꈆEV�jU�Dk0�_�-2�m5�n���n��� u�\��)��^D�HH�67~#ֱ�&�{�qܤ.��UOj ��3���%�����#��s�@��s!'*C�A���B�K�\"��X
i����?�>�A�?^&*�[@�D:�����a�=`'�A!����q�����cx���e� <� �A^� ��o�?�E�N 0�������|�_ ��a���[a��)��A���� ܼ�.A��ސ <����41"W���jB�����gAD*�[r �\�ћ�&8F�A9���<(G���<��@�eC� ��'��S��B�1��z�P�Cg
�1������e7ֈ��� ��G�A����U�,��%�h�����s%�Yo���qd|aȯ� ���Gd�C� \5 ����\&8� ��?��hA+��&x�,X��^�Y�g��C~.��ȟN~�3ȟI�,�g�?�����_@�<�O"�d�瓿��S�?����F���A���E���C�H�������?����_@~���/!�B򗒿����$�E~)�e䗓_A~%�U�W������_D�*�/&��/%���Z�W�_G~=�n�א����ɿ��u�'���D�����o"����7��W��W����K�5�z��˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸�˸s��}g�Gg\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\�e\����W'\cA�|��Y��rj�5�t_ph�G��,���Z��>��x���5�!8V�������u�fA�:��8\��k��e��p���Y�~�8\g�\A�v�5׋p�
�5p�당B���ۯ��o���{�Y/��4O���p�����Mp���pU�޾�g�*�%d�p�4[�Z8G��
\�s��/�5?_��8\3��x���Kp=<O�z�IBV/\Cp��Ɠ��[N��?W�|��Up���=pu��n�� \��U�@�Z��������4\���o�5�!�L�J��.|o]�՞�M^P�E��QIJ�@�/����MM^)G��x4��!R�����k�4���u-Wy���vS ������ڥ��SbL�ٶ[�yc��]'m��PG���K���H|M �z�m���P ���T�9��]w�"1�S�6�g��jVȶD��*���p�7��}���Š�_���<h���n�� ��PFB���':��vH!)�/&��DSs�z����v��4��$j�y���%����6�T���ۺ=.���p�x7��Bm�&)�@�y߳����+��B]��ł�`��Dܽ�9^���\���X�Oy4�76� ��	�$��F�ۍ�+XW���Qq��9TM)�uD�JK����"%3!w�?��@r7�y�*�vPZ��I�v�_���66;���6]FՁp�yI�Ѕ ���=m��\�pp��y]�۳ί<)彌?�w%��:[}m^_4���.�V7QVtC].�zh^qo|{Dr)��I�����Q?�=~(LW�h��X,���]�T�8��X�JVD�:��kj*V-��P\N�������nW���l\�媄�]�N���z��(�c"��Q���Դ���{̄���	��e���"����NV�L�:�"�ʘ�G�c���}ɏ����;p4�t��2)s%��"ʪbRPm���0�0B	��țK���n7x�J��ͯ�˷��&�]Fz�~�nnM@���IjP��5:�V� �(���TX� �ި�Z'�`�����9�".E���K,rK�Q+��*�=��*M���(�������# �2�`�0������$P	����Q��J�F3�x�����9aNɤ��c�60G��0]��vo�Ccq�|���`�!	_���Ҁ׳y5�#�7Pږ��K��wE���)�]a4���H'(X���ds���pz��h��
�s��G0`�AG�
�&��V�?�).���΂Ǐ�H��#0��9f��M0d�=0vG��64a�F��A�k�!��9���2�%���hO`���~��?2%�>�`���a`�/��?B��-����#��8���1�[x=��odS�1)>�O�]ٌ���Bv��z��,_�[�=;G����A�����9F�yL��ܳN����F
OC���`a���=�a$�Ix6�[x�?��������	ݖ�)�ȁ,TB;r�P_N�pgN���V�ײ��߆��?GBc�������#dWѤ෠hO����d�UB�0���JA�fY��r�v�ȅ�t��%��ã�Q�7���7Xx ��UC��jb��\d`ɬ�������)�EA�(�^�m.
�m�.,~hhi[\�;�ԓh�V�n��SV�tJQ%iP��؃?a�9�$�CV5O3�>��j��ʬ�\����n��U�Z9�as��4(����<�"	����k.?L��@Kxj:��w���"�=���u������<�_�30��<���L�C*�-����}3����`����P�ߚ	��GF���X���'�?f���dW���B��T��&
����� ?��i�?�V'<3��lBG �1�W{��9�8��pc3+V'u��L!�p��D<t	��w�:��h�s�c�u�JD�x�,)4��2J�J+gpJ������=���_����.�e�W��nV��9BVJ�J��f��Ss@�l �1��S�d����0 �=7[]���2�μ���tz�/�ܵ���T��j�Q�*�VXX�:и�JR�;�l�p��2ᕹ��g��:Ԙ5l |	���%V��o�1��itM����������'
@����%��W �!W+��8T����DS��?
��Ǉ�P��̬�Z\K��o�P5��{!(�%���	��W/��ݘ��$���n�:��ⲝ��cPOR|�����j��n�p��T��",���w���=L]}%��M�ԻN�n=�W���7%D	Ds2���'�A�_c"���d���||>��C'�	ߜ_/<9Ԫp״r��*���V�QS��I��m�q�C�6��4����cr����t	��k~0=7j��P7��ZٯI������(o?�?� ���.�'�n�	�9����'���%�G#܂�9�`��Ϝ��>��-�m
,
�Ű����S��˥g��S���:����\�]�09w�
}��P�������N�����m�C��b?c��䩥�OO�
��)��sUVM-FEa�T�V��cav�H�-
�^xLK{?j0��m,�������U���Y�>-;g<,@�3���}����i�U���V)<t�i������U��˲�r=�����>���C�#���n�_���� ��}u�:��V�;π��@�St�+k��C��B�9�儿j��ѳ�S��(��D
 �7K�g;���9�� �s��$�x B���-��ֈ�3T �A�(z"�&9@�f\�Ȉ5��55�EvF�"\��S�e,�˫��d���80��qzĈs��Aޠ|��� �ǳF���g���	��#,��,���lG��9����$,��qa��Ix|1��ϡ�p|a'�a½��E��G�~��P���s�>�';	��^O���£�/<��s<��%?O�Cx�"�	YJ�	�n9��_�񽄝��'�!<1�#�>�c�?G��^�>N�Ix�o!����Jx��(�q����\�p���$O�� <D�f	�'�E�c��J9λ��C���H�6��$<@س��#�8�1«�Q�o',�q�3���K(?�+	��F�����(�	��� ��������A����	o!\�� ,Vr��a�7�?�[�Tq|aO5�&!����n&<Nxaq���>���'|�1�C�Vr<���/��q���pC�Gx/�-�gTR�\���~���b������&����?� a�%�K��p�
*?a���G	��r\�����p/��Q}'�I�Bǣ��C��p�*����CQ�[$�$aa5�o	�\L�!��p��k�_t	�'�M�c�_",�q\q)�G� �A��ʿ��'<@�5£��kI��DXts������� ��^XG�Yñ����=�� �K����!���Z�a���%|���A�}�G	�AXh��g���/\C�E8Hx��=��	�@���������!����?����7P~��	�4s�����Jx��o ���p=�%�����8!|��_H�5�Ήr���[	/%� ���.��w�%�u�{	?Jx������$|���u˄	&\I8/��e�~�"��[�D8N����G�A�'�C%�8�/+�~Cɟ���W>�p�e��"\C��p3�m�;�"�A�{	�Fx�/~��}�_!�}�o~��'���	o!�6��	l �>����+	?M������!��0a���p�;���v~�p��~��̈́� �Y��7Ry�N�A��?M�����[�F���[�?Dx�V��I�n�K	�/��w~��6¯�Eر������&|�	�$���s�q���|�1�B���	���p��m��#',���?	�Nx���;�s?H�Ex�p�1�W' �h;��U�o#���	_C�ۄ�������?K8�rj�O!����|��q|a���#<Hϫ����	l���
���_v���Jzzޔ��(�����l��P~�L����Q���uS�9�?�E�=>�W. ������M��A���<���Gz���%?z����X��s���K�R�k�o$����G�ރ������~C����O��"\N����G_Ox�. �u�9��<EX$,+��M��."\��q'�A*ߍ��N�?EX���;�k�9>#��!L�%�����U����{%�O��q���Q0�����pXyN��D����G	�� �G	o�������L��E/�q�7F2R���Ȟ�=M�Y���x���,ʟֳ�����~�p���3�ꇞ7Y�q�������"r�l�w.ǟ$<V��{��8w.��W��G��|�G�o \@�>Ex��=��?J����	����T�]ɱ���|7�\��W	�l��1�[/�G����)����%<���̈́{I��OX��/+���D�%����+	�� �q���EX���<�QjW�S{9�d��7.���!�[�w2o�#���W��>%��x�p-�-���Ix��m�h��ۄ�i�hL�5�,�X��C�Gi=B8��'qN6`р��%�1`���π�2�o���`�3�Y��c�e�`��pĀo2�;�^~ƀ_5��z|�Wp�_i�]���?n���2��
��Y
^x�W�ǀ�ۀ�j����t=���؀����Z�5��O��L=�2�M,���~~ʀ_6�#��,=>ˀ��\k��5���`�w�x�,}�yҀy���2��m��g��\>ŀ� Hp���W'\���up��+W�\���+W�\�pm�k\��� \��Cp���a�n����	�p��N�n��#p킫��p��>�v������5p]����µ.\��5 ����8\���Cw��I�>�^�Z���u'\���.�>���/�����\_�w}�\������7���^�c�׷�.y~�dz����p}�B���k�/�)믒��6��щ�*�v�H�k
�kM5e�m['0/�vܲKI�m�}j��m�)���V��N9�Z?y���c�.%�T�^�f�������G�������O9�v�iv,��07w�c��o��I=<�"R��3Պ�q*�J�a�Tc�Ƕ�է`�P��݀f���7M�<q��L�SO�y}��S��܊M��l���ޤ�Oo���S(�v�\}nd��J����45%�Tlc�PBS���*���ml�J����fIԛc���jȄ�П�0<�8��G��t�����0~s@��]�EFX�����0?��0=.�8 b�dq ����P�9��!c�)�jL�T����E׮�.#�z͢�O�4`�h�S#������l�Zֈ~�PK-M�E�KX�"B��,R�O��#Mi�R��l*����Uf��<$�f�yn�r�O�FKy��.�K��6���M4ݙ$M]��iVQ5'�4QRJR#�HM�!ug���K��,���4$�:��^4k������7���?���d>S��L��g���_j�|^,�y����2���O�<2��p��*�֙�G�U+X��Q2ڭΥ�8�!wR��0f���z�a���-*�bj�� ���k�(�Q���M��0J&q���c�`8�1�d]՜e$|\�v���:��	%S�&XCRC�h#[�8�&��q�@�?��m2--5e����s^p�׷:	�4�r�B�Lb��a5YS�K;�5��r$��A�A����J�~Z���f!-��x[�H�~��l���-.�[;�H�O>�V+�,sFݳ��d	N>�T���Y�5f���V�g���^�8�a�����¯�rUZ�����E
>?6��t}B
��c��_N��uGa��[m:X��a�'�����b�
ʵ5�3��@E*�Vrn���?+i��!X��%�l5�uO���zbƨ�#f��Vp2�&���@0h�A'Q�J4C�6�j���j�;�~����N�
�5�ﴩ�d�<�Y�1h!M�Y�N�2Ӣ���,���v�8Nc��n��`?�I�D�/�z�ws-��M-�M-N}�¸��o[+D�I`��Ԏ�;p�`�u᏿��m
v̥ɐ>�����t:*ڴF}
����� ��퍘Wꖞ�aOv}鱯SL`�o���[��
������5��Gk$�N�H�pୈ�A�6�:Ҥ�5q0NI��V[|u�U���Jh9�k� ZT�01U&�rؚT�^��,m�DiDg&L����u̔L�+4�~�Wj���4�]0��`�W��]}����m2�]�NW��Uk��C�D,� 'R�м���mgu�����7#ya��z��:���n�+����D������u��u��/:�Ԁ���k*��(��N=툄"PcӺ3I��4s%��.Ϻ�-�<��OŚ"v�d�qZ�ŧ�T��!v4�6�<�Q�/�˧��WyyIN��_eL�fm�馱 hc��*�y�v]��gz�E�~�sLļ�a*��R�����j_M��I�Q_B�XLc9N���J���j<��.�ph>]���Lz�L��BM�^]:z�TƱ����ڥx�Kõg
^���y�1��Li�Ukh�&t�c_�B�4fm�v������֙�5�F�Ū��MC�.)
�
��]�2PS63Z���H�kLŲK�r%e�[���5ű�wtR���]��=�E�9���������YmS��.�a*�o���A� }�W�JRG��[��2�[�&�]�UkT���`帘(�l�f.����8�B�֠��pWŢ�������H�.���6�oY 7sBr�۱rf��I���`���ėjlڢ3j*�^}l6K��q���6��	��o�x/g��K���1��[[ ��|'�:n��0#V��)P��Hc3�	��r
�L�R���RoK91�s�Zc;L��F}��K�N��������ĉ��ܱ������Y�m5[�^&y��ny]%�yz���8�4f��z6�����x=|U��`�Ն��Ўw�?����@W$�������S��Ƣ�A2.�X�͍g��~YCf�k�c��:�u8S�M��g!*�È��mGz�3l�(_�0�@��� �d/b&e�ReX=�PB�l@��b�3����7OCu�$�*�_Z�ξ�J����Z�7'ΫvÙ\��F�o��x2�'�2��Z�~�+���e��'�}��L_n���tM���T����Z�Hk�?4O۲�ҕ��κf�+ƕ�G��D�N�qxG���X�fFc¾ús��;Oд'�*u�������Jܲ�38�]~�j)�ڴN�Ҫq2=��l<u��x�H`KN�K��������`��;R�˻��j�ʎy�ϰr:��c� ޛp�TӺ֩ͫ����~�yjٷ�ں:�[�]0�+M!NSH�)��Re
Ya
q����̱���A��fƫ�|V�٪6��ef�i���4��*5��*�6�U��3�̭��Z�Y��愥�bV�Y�4��4'�2Ǫ63_m��B8Nᔙ��,���\IL��-�т�
��`Qgdѩ,j�\�RV����e,7�jձ,:���*�p��9���D��˞eQ&W��d-ګE����E��;�E�(3�ҪcYH�\�]f���-��E�\U�j��2�3
��� mf��Lɢ�[(�
���WY�&s��V�ݢZ�VW�K�Z���6i���9��**D�Wr�YZ�}r�����YV���Ot�;����x2��D,�+[�0`j[ǃh��)�P9����)����V0���pUUd��D8}�K�Ր��Hd���Ay�m����+���++*��\�P�U`(�Ωc������y��P��.6n�[����u_U�P�q���0�<�$�G3ϣv#����K4!���@|�6�>x�<��~o��_ҩyX��XF�Y��Whxf
c�qY��ڤ��){/�g�
b�_��&�g�\�d�Lq�X�@�=�pw�M��������b}��= -k���._H�,D�K��>?�+ ŀ��~|-!*���"8<��K+@����HE�H��PC�{O(�|{��;n�a�A/C�`0������G����y�L���
+��"�S�d �Đ�U-P �}!��@�DC%e"R���&&b� 2�٦,��]��'"%b�$�H�̰�}5��e�Z�4/O��0VTL�;�ejG�X��E$ b�{a���Vl锈��!)��Iy�q��d�m9f�!��e���\�{&'�Z2���bl���tڤ��RF���a�R�P^F_<�|-S�'�n��"1�o7�����bW������X��'GY����tM �ʩB#��M� �|q5�ؼ���g�u�@�ѐ�9�{�-B{�sq��$��Y�طU|x�_���RW$^b٪)�ي���Z�)��}s-3WŨ/�*U��n�G��E.�^���l�X���p,^<i	ZIS[^&UM+���.���di(�&	���-i�5Z�4A�\����I7M*�Vo��,�N�$?�e�b��<O
�R�M�/uz�_1��6�	����
��_Y����'����,��O�)�~�ȗ�#:?�`[�s���Om�s�Y�6��u�%܌N�w�m����E�/�-��mKE�{^KD�}�bnYO�|^Ky�u���h��i�hI!��׎bm���X>>�10�,N�9����〯]����ه4�)�)w�P`�Q�	�
��X����ck��_C������f�]g]�)-�c�C�L�V�v�����F�@����3���ϗQ�������Eœ��n6A�\�EX���bq�K�p�T�"�b���z��<�)/S@�r��� ���l�=2?��%!�Ȟ�)�9���M23|�q���n��33��b�����������M��ء6�l�i��&�	�����YV���'�Y�u�6���j����GeZ.�Nf�v�/������|�/��U�Ь�j�f'�/I�(����\�aA��5U���ƣ!u}�j��0�>�h8r}B����5��SO*s�ߋ��h�"~Xӆ�qL#S�$�4vCg\o��!Q�KјM�L��l*Q��b�޾�Ŝԫ�%�F���1�`ka��h��z�!f�2�^�!Υ�	��<ѪVk�L�$�Y�1NY��79bk��fP	Q���\��G�l%0A�Ѽ��C���@��E���	��Ap�r/⯪�hJW�6���&quR�[�z�B���ɖ�Y)�2��+W���Pr�]d|��XZ*�S���i��h���������L�
pj��UZ
����ԙ��O�3���;f�?�`2+�`��k;_��N�d2� e����(�8����b٘��� 2��PI�vdQ'�f�l�����Z�줜+�\���*�E��i��9'J�NI�S�m
�H��X���t�Y�7��0�:���_��/x3g�'�g����2���Xr����.4|�6 ��1��C�PL��m1e�v��J��*� �fԒ�[�%?Hc�h��D G}��m.=��$���E�#�)]*Z>	t�k��ԏnһ���N���k��ŇR�J>�4U[L�
����X7�Ӹ�~'�q���?�4A�Cb&>uj�NIPF���UeAj6A�2��[�ŭ'IH@�gE
�آ��&*˵�:����W��QJ�k�ƩH�|(�D��M��2�xJ��x��]"b���'P�O���B`�QQ��W[N��	C2�j�wEX56��:��j�t@���ƶ<����@�ݰ��~1�h��%V�RL��Y�J�2ӘK?�h�6�/Ľ+t�q����������?�Ͽ|�=�ڜ�1����\�/5ØK�17I/�1�"ݘk�x2��'1����i̝@9LɘKy�>�*u<U#���49��V�BΔ:>I�ڤhp;;ђԵ�����I�[�����eYD|��Ic�>�쫿G{L�d�@�f��Z�ȼM�;��OeuvJ�h����̸�ﬨ̬��g:��Դ�j�_	�_�W�W@.����Ɔf�o��jň~�D%���0姾�e��tZ���v�5l�,Q?����\�!Y�q�q��X���_99���+'��D�c5q�8�P+�m���HW
T�/j��jHq����bX��z&>ф#��^�x�+����v,���dbb d��@S��:$�����6z�0V�<|��nq��"$ȩT�@h��xe����'���Dȏ&�at�hYJ5BV1���2�b��'�V6����+aH�b�c�@kPZ�l�mb�3���}��&�l&��"��Tt�t��~���Ѿ�Q���|�5c�n��R<����!�F��,Q�m	(���"��m�'��؈�R$-����J�I��U�?�f����k/H�iS��y'�[��v�XXhl�.BR��5�"��@�n��c[��T9�mH�DۯV���+��"=��"�⥆�\(b���H�H�
�d��D���wA_�FA�Tpb�Dto3D��"��?��B%�ў5�:�}:��)1\�����Xcǟ|��.������B����D���q���e�VP�'3��G��X�6ΒҞm�JM46�B�[LM[�i��Y�ڪ!��m׮9R� ��C��Os����OkLE���NW�q�EY���	q����W�o��#��z�}@��tt��tn@s< �=@hHt��	ʚG�E~V`��@\��ZK�� ��~���aaJ=���Y\,	J!�c�L��ڵ��.��m##�-U2�'����um��4E��mRo�Qka��(��[ˁ�2����,C�����V�<��w�M�}���$>V��-�`O2g�2NuV������YUe�++3�'�����?h�`?����Wy��l����Y�����w�8����;��T�ƁWG�ȼ%Sy�C��7�cZ�ǜ0?���4��O��z���2?��A��W�'����������ʕ��'���K�O�SSr���!Nu��kq���B;��Gw��N�(�8&�&���I�E������8j�/�F;bʂ�t}����K��2�`��.��,������uai��|�"��_?��())a�\�
�P�a��S�]���_s{����D_T��V_�m#_�� ��d�j֝Y
��U�uͥl��%J��<����П�`�´�n��2jX�|x�����:*��?~�����U�,��;������ʊ��?!Ψ�7�4��P�la��g���=���`K3��Oq�ڒo)�i@G���k��x�7���mjɗ9��G�}���L�;�#i�W�g���q5�n����3��N�V��Q�ǳ�|��df�gj�Z���MkW$�]�Hᐲ��fZ����U��',��^Z�Q�4<�:�I|���R�*cA��;��qp�@�q��t�I��C�TL��N�����/l�V0��//-���	qj�3��LĦ�%L��+K����9!Ϊ�����M��JX���c��
y����\U�����,��B�yI3�m��� 5=sf���p��6Ԯs{7�^���{����q�ƞ�dp�FMp�����,��T���Ҟ��5�-����a���/�c�8�'�
�g2;����ĉ�H��/�te�ifPf�����4��"���C��/#PRWie�������2�2κ�芄�q�=�����]`����<�.�$���Pxkrk�/.B+���x1)N"o������]Ӹ^��)z�Ḅ+]>���+�"A�(3>��T�
S�Nq+[�B����F%_�v*%��
�z������h�#/^^��g�m����q(��"m� �R��=��K>�M�슍-��bRb[õ��Z�ǽ�^�%��֏zXs���R۴��2QD��L�HMC
Ƥ�	��D7A�<�+,�	�)[a��l�|sK���͵��D��h�>���>۶�Q��b���\�H��6nj���dq�(iCp�۳���-^T(.mR��GM��L��F<vd5Q8iK%یk�E��[_0X�����a &��Q��߭��]QD��xCV�ved���	0��@��6����X3 �nZ7�	�)�H�>(�~�&�iG}TB�M����L��V��ȼ~�I!Ȋڦ�ɽ��*19*�mnjrol�ol��`Omhi҇�ۤGݡ��v���Kfr�:�:���j�㎪�g�����E�P�����]/r��z �dxb���'M
O�&������|5nlq7��^�U�M���u-���E��Ӓ�E�O
uT�7n\�_�j���e�ʕ��p����Ph׸Jm�v����BAq��G%�p??j��N�:���%�
X��A���6~�u":�.�{�¡�@G"J��|�֮ߴZQ]�9kK1����1MW�-�󀯡��=�h�ʍ�ټ�T=���S�j8�D��5(�B��o6U<l���~cd��6���x�'�ƹ�p)ڷ'`d����l!����Q*���'��wJ���!�^��V�g^H�5hk��1�}�������³i��n~�ql빦Pd�%�6ct�<�Nk_c��8�%������dW"�:�}1�JKY9s	[�f���b�����ua[��cp�$�M\R�:�`�XR�FM� ��/��~[��1�/(���P�%ā~������'�;��_��pLS�`7��@h�O���idZ2��I��/�2�5���7���X��@�]��\��++��x���.|���떀@�$����.�<Ĉg���p; ;���/y�Oc ��l���0��A��vU�	 c��\z�8��X��?��OSWǺ�3��������Ҳ2��S�ʬ�����-��K㫨kI�nt��.��Ǣ	&��Q^����U�����\�������69��qa���	�n�sL6�y�veIO��J�	�N�#q���Ƶ��j[ �fq�&P<��Bn��:Fɫ��[�Bˡs'i��mX��Ӽic���JM4�w�$yY�'Z�V�O�F���T�G,>Կ��O���w����	�(~��WVYQ���'��(�۽Z}��_�|Z�|L���e]�5�p;~���K3ˢ�T��:���>t�e��h^��:|Q1n0��!�|m+Q�
��ϗ�|
_����M���~E]R����3Qk�(��ID�/��W��֭�]���^�U�u-��L�}�D4�;����2�6����	)��Q��|�xp�:'ĩw���b�f͐sݦ��׻�_r�9�*��x$�]�&9�uAW��*Ἑ}�mr6����x�]%�B��(&��i�X�d��v�Z7N�L�ޠp��N&4�+��`�^��E)��g�J0����8��խyZ�bʲҦ�	�j���mr׶��l���J�U�<��W������堘�`Q��V��v}���Rq�$-M�ݺ��JJ@����ͤ�+mƪ�T���ʀ+��n-Ly��Wȡ�ڵ���U8}�1F?/���¡�l�I�Js�{ܛ�soj��z���b�#��:_�۸���S�}�����z��r�dV��c�*�J����T�VV����5_�/~ғpHQؠ�H��]ɾ��
�Ry�jUB��j�R,�"�U�&�������jq�X�|?dRa�>h��}PG�/���ݼ�yscK��|!�����˸�˸�r�� �1 $ 